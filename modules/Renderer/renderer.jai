Renderer_Handle :: #type *void;

Render_Camera :: struct {
    position: Vector3;
    target:   Vector3;
    up:       Vector3;

    fov_radians: float;
    z_near: float;
    z_far:  float;
}

init_renderer :: (
    window: Window.Window_Handle,
    clear_color: Vector4,
) -> ok: bool, Renderer_Handle {
    renderer := New(Renderer);

    renderer.window = window;

    renderer.clear_color = clear_color;

    ok:, renderer.wgpu_toolbox = init_wgpu(renderer.window);
    if !ok {
        log_error("Failed to init WGPU");
        return false, null;
    }

    WGPU.DeviceGetLimits(renderer.wgpu_toolbox.device, *renderer.limits);

    renderer.transforms_uniform = create_transforms_uniform(renderer.wgpu_toolbox.device);

    renderer.materials_uniform = create_material_uniform(renderer.wgpu_toolbox.device, renderer.limits, 1);

    renderer.model_render_pipeline = create_model_render_pipeline(
        renderer.wgpu_toolbox.device,
        renderer.wgpu_toolbox.surface_configuration.format,
        .[
            renderer.transforms_uniform.bind_group_layout,
            renderer.materials_uniform.bind_group_layout,
        ],
    );

    Window.add_framebuffer_size_change_handler(
        renderer.window,
        handle_framebuffer_size_change,
        renderer,
    );

    return true, renderer;
}

deinit_renderer :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

    for batch: renderer.batches {
        array_free(batch.instances);
        WGPU.BufferRelease(batch.instance_buffer);
    }
    table_reset(*renderer.batches);
    deinit(*renderer.batches);

    Window.remove_framebuffer_size_change_handler(renderer.window, handle_framebuffer_size_change);

    WGPU.RenderPipelineRelease(renderer.model_render_pipeline);

    release_uniform(renderer.materials_uniform);

    release_uniform(renderer.transforms_uniform);

    deinit_wgpu(renderer.wgpu_toolbox);

    free(renderer);
}

start_drawing :: (handle: Renderer_Handle, camera: $T/interface Render_Camera) {
    renderer := cast(*Renderer, handle);

    update_transforms(renderer, camera);

    for *batch: renderer.batches {
        array_reset_keeping_memory(*batch.instances);
    }
}

draw_model :: (handle: Renderer_Handle, model: Model, transform: Matrix4) {
    renderer := cast(*Renderer, handle);

    for node: model.nodes {
        if node.parent_index == -1 {
            schedule_node_for_drawing(renderer, node, model, transform);
        }
    }
}

end_drawing :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

    using renderer.wgpu_toolbox;

    ok, surface_texture_view, surface_texture := get_wgpu_surface_texture_view(surface);
    if !ok {
        // @Todo handle this more gracefully
        log_error("Failed to get Surface Texture View");
        return;
    }
    defer WGPU.TextureRelease(surface_texture);
    defer WGPU.TextureViewRelease(surface_texture_view);

    command_encoder := WGPU.DeviceCreateCommandEncoder(device, null);
    defer WGPU.CommandEncoderRelease(command_encoder);

    do_main_pass(renderer, command_encoder, surface_texture_view);

    command_buffer := WGPU.CommandEncoderFinish(command_encoder, null);
    defer WGPU.CommandBufferRelease(command_buffer);

    WGPU.QueueSubmit(queue, 1, *command_buffer);

    WGPU.SurfacePresent(surface);
}



#scope_module

Renderer :: struct {
    window:       Window.Window_Handle;

    clear_color:  Vector4;

    wgpu_toolbox: WGPU_Toolbox;
    limits:       WGPU.Limits;

    transforms: Transforms;

    model_render_pipeline: WGPU.RenderPipeline;

    transforms_uniform:    Uniform;
    materials_uniform:     Uniform;

    batches: Table(u64, Batch);
}



#scope_file

Batch :: struct {
    mesh: Mesh;
    instances: [..]Instance;
    instance_buffer: WGPU.Buffer;
}

Instance :: struct {
    column_major_transform: Matrix4;
}

Transforms :: struct {
    projection: Matrix4;
    view:       Matrix4;
}

Uniform :: struct {
    bind_group_layout: WGPU.BindGroupLayout;
    bind_group:        WGPU.BindGroup;
    buffer:            WGPU.Buffer;
}

schedule_node_for_drawing :: (renderer: *Renderer, node: Node, model: Model, parent_transform: Matrix4) {
    transform := parent_transform * node.local_transform;

    if node.mesh_count > 0 {
        for node.first_mesh_index..(cast(s64, node.first_mesh_index) + node.mesh_count - 1) {
            mesh := model.meshes[it];

            instance: Instance = {
                column_major_transform = transpose(transform),
            };

            batch := table_find_pointer(*renderer.batches, xx mesh.vertex_buffer); // @Todo figure out the key
            if batch {
                array_add(*batch.instances, instance);
            } else {
                new_batch: Batch = {
                    mesh = mesh,
                    instance_buffer = create_instance_buffer(renderer.wgpu_toolbox.device, 1),
                };

                array_add(*new_batch.instances, instance);

                table_set(*renderer.batches, xx mesh.vertex_buffer, new_batch); // @Todo figure out the key
            }
        }
    }

    for child_index: node.children_indices {
        schedule_node_for_drawing(renderer, model.nodes[child_index], model, transform);
    }
}


do_main_pass :: (
    renderer:        *Renderer,
    command_encoder: WGPU.CommandEncoder,
    texture_view:    WGPU.TextureView,
) {
    render_pass_color_attachment: WGPU.RenderPassColorAttachment = {
        view       = texture_view,
        loadOp     = .Clear,
        storeOp    = .Store,
        clearValue = WGPU.to_wgpu_color(renderer.clear_color),
        depthSlice = WGPU.DEPTH_SLICE_UNDEFINED,
    };

    render_pass_descriptor: WGPU.RenderPassDescriptor = {
        colorAttachmentCount = 1,
        colorAttachments     = *render_pass_color_attachment,
    };

    render_pass_encoder := WGPU.CommandEncoderBeginRenderPass(command_encoder, *render_pass_descriptor);
    defer WGPU.RenderPassEncoderRelease(render_pass_encoder);

    WGPU.RenderPassEncoderSetPipeline(render_pass_encoder, renderer.model_render_pipeline);

    WGPU.RenderPassEncoderSetBindGroup(render_pass_encoder, 0, renderer.transforms_uniform.bind_group, 0, null);

    current_material_bind_group_offset: u32;
    material_bind_group_offset_step := to_min_uniform_buffer_offset_alignment(renderer.limits, size_of(Material));

    if (
        (renderer.batches.count * material_bind_group_offset_step)
            > cast(s64, WGPU.BufferGetSize(renderer.materials_uniform.buffer))
    ) {
        release_uniform(renderer.materials_uniform);

        renderer.materials_uniform = create_material_uniform(
            renderer.wgpu_toolbox.device,
            renderer.limits,
            cast(u32, renderer.batches.count * 1.5), // Overallocate 1.5x
        );
    }

    for *batch: renderer.batches {
        if batch.instances.count == 0 {
            continue;
        }

        batch_size := batch.instances.count * size_of(Instance);

        if cast(u64, batch_size) > WGPU.BufferGetSize(batch.instance_buffer) {
            WGPU.BufferRelease(batch.instance_buffer);

            batch.instance_buffer = create_instance_buffer(
                renderer.wgpu_toolbox.device,
                cast(u32, batch.instances.count * 1.5), // Overallocate 1.5x.
            );
        }

        WGPU.QueueWriteBuffer(
            renderer.wgpu_toolbox.queue,
            renderer.materials_uniform.buffer,
            current_material_bind_group_offset,
            *batch.mesh.material,
            size_of(Material),
        );

        WGPU.RenderPassEncoderSetBindGroup(render_pass_encoder, 1, renderer.materials_uniform.bind_group, 1, *current_material_bind_group_offset);

        WGPU.QueueWriteBuffer(
            renderer.wgpu_toolbox.queue,
            batch.instance_buffer,
            0,
            batch.instances.data,
            cast(u64, batch_size),
        );

        WGPU.RenderPassEncoderSetIndexBuffer(
            render_pass_encoder,
            batch.mesh.index_buffer,
            .Uint32,
            0,
            WGPU.BufferGetSize(batch.mesh.index_buffer),
        );
        WGPU.RenderPassEncoderSetVertexBuffer(
            render_pass_encoder,
            0,
            batch.mesh.vertex_buffer,
            0,
            WGPU.BufferGetSize(batch.mesh.vertex_buffer),
        );
        WGPU.RenderPassEncoderSetVertexBuffer(
            render_pass_encoder,
            1,
            batch.instance_buffer,
            0,
            cast(u64, batch_size),
        );

        WGPU.RenderPassEncoderDrawIndexed(
            render_pass_encoder,
            batch.mesh.index_count,
            cast(u32, batch.instances.count),
            0,
            0,
            0,
        );

        current_material_bind_group_offset += material_bind_group_offset_step;
    }

    WGPU.RenderPassEncoderEnd(render_pass_encoder);
}

create_instance_buffer :: (device: WGPU.Device, instance_count: u32) -> WGPU.Buffer {
    buffer_descriptor: WGPU.BufferDescriptor = {
        usage            = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Vertex,
        size             = WGPU.to_copy_buffer_alignment(size_of(Instance) * instance_count),
        mappedAtCreation = xx false,
    };

    return WGPU.DeviceCreateBuffer(device, *buffer_descriptor);
}

to_min_uniform_buffer_offset_alignment :: (limits: WGPU.Limits, size: u32) -> u32 {
    return (size + (limits.minUniformBufferOffsetAlignment - 1)) & ~(limits.minUniformBufferOffsetAlignment - 1);
}

create_transforms_uniform :: (device: WGPU.Device) -> Uniform {
    uniform: Uniform;

    { // Bind group layout
        layout_entry: WGPU.BindGroupLayoutEntry = {
            binding    = 0,
            visibility = WGPU.WGPUShaderStage_Vertex,
            buffer     = WGPU.BufferBindingLayout.{
                type             = .Uniform,
                minBindingSize   = size_of(Transforms),
                hasDynamicOffset = xx false,
            },
        };

        layout_descriptor: WGPU.BindGroupLayoutDescriptor = {
            entryCount = 1,
            entries    = *layout_entry,
        };

        uniform.bind_group_layout = WGPU.DeviceCreateBindGroupLayout(device, *layout_descriptor);
    }

    { // Buffer
        buffer_descriptor: WGPU.BufferDescriptor = {
            usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Uniform,
            size  = WGPU.to_copy_buffer_alignment(size_of(Transforms)),
        };

        uniform.buffer = WGPU.DeviceCreateBuffer(device, *buffer_descriptor);
    }

    { // Bind group
        entry: WGPU.BindGroupEntry = {
            binding = 0,
            buffer = uniform.buffer,
            offset = 0,
            size = size_of(Transforms),
        };

        group_descriptor: WGPU.BindGroupDescriptor = {
            label      = WGPU.to_string_view("Transforms Bind Group"),
            layout     = uniform.bind_group_layout,
            entryCount = 1,
            entries    = *entry,
        };

        uniform.bind_group = WGPU.DeviceCreateBindGroup(device, *group_descriptor);
    }

    return uniform;
}

create_material_uniform :: (device: WGPU.Device, limits: WGPU.Limits, material_count: u32) -> Uniform {
    uniform: Uniform;

    { // Bind Group Layout
        layout_entry := WGPU.BindGroupLayoutEntry.{
            binding    = 0,
            visibility = WGPU.WGPUShaderStage_Fragment,
            buffer     = WGPU.BufferBindingLayout.{
                type             = .Uniform,
                hasDynamicOffset = xx true,
                minBindingSize   = size_of(Material),
            },
        };

        layout_descriptor := WGPU.BindGroupLayoutDescriptor.{
            label      = WGPU.to_string_view("Material Bind Group Layout Descriptor"),
            entryCount = 1,
            entries = *layout_entry,
        };

        uniform.bind_group_layout = WGPU.DeviceCreateBindGroupLayout(device, *layout_descriptor);
    }

    { // Buffer
        size := material_count * to_min_uniform_buffer_offset_alignment(limits, size_of(Material));

        buffer_descriptor := WGPU.BufferDescriptor.{
            usage            = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Uniform,
            size             = WGPU.to_copy_buffer_alignment(size),
            mappedAtCreation = xx false,
        };

        uniform.buffer = WGPU.DeviceCreateBuffer(device, *buffer_descriptor);
    }

    { // Bind group
        entry: WGPU.BindGroupEntry = {
            binding = 0,
            buffer  = uniform.buffer,
            offset  = 0,
            size    = size_of(Material),
        };

        group_descriptor: WGPU.BindGroupDescriptor = {
            label      = WGPU.to_string_view("Material Bind Group"),
            layout     = uniform.bind_group_layout,
            entryCount = 1,
            entries    = *entry,
        };

        uniform.bind_group = WGPU.DeviceCreateBindGroup(device, *group_descriptor);
    }

    return uniform;
}

release_uniform :: (uniform: Uniform) {
    WGPU.BufferRelease(uniform.buffer);

    WGPU.BindGroupRelease(uniform.bind_group);

    WGPU.BindGroupLayoutRelease(uniform.bind_group_layout);
}

create_model_render_pipeline :: (
    device: WGPU.Device,
    texture_format: WGPU.TextureFormat,
    bind_group_layouts: []WGPU.BindGroupLayout,
) -> WGPU.RenderPipeline {
    ok, shader_module := create_wgpu_shader_module(
        device,
        path_join(#filepath, "assets/shaders/model.wgsl",, temp),
    );
    assert(ok, "Failed to load default model shader"); // @Todo handle more gracefully
    defer WGPU.ShaderModuleRelease(shader_module);

    // =========================================================================
    // Vertex buffer state
    // =========================================================================

    vertex_attributes :: WGPU.VertexAttribute.[
        // Position
        WGPU.VertexAttribute.{
            format         = .Float32x3,
            offset         = 0,
            shaderLocation = 0,
        },
        // Normal
        WGPU.VertexAttribute.{
            format         = .Float32x3,
            offset         = Vertex.NORMAL_OFFSET,
            shaderLocation = 1,
        },
        // UV
        WGPU.VertexAttribute.{
            format         = .Float32x2,
            offset         = Vertex.UV_OFFSET,
            shaderLocation = 2,
        },
    ];

    vertex_buffer_layout: WGPU.VertexBufferLayout = {
        stepMode       = .Vertex,
        arrayStride    = size_of(Vertex),
        attributeCount = vertex_attributes.count,
        attributes     = vertex_attributes.data,
    };

    instance_attributes :: WGPU.VertexAttribute.[
        // Model transform 4x4 matrix
        WGPU.VertexAttribute.{
            format         = .Float32x4,
            offset         = 0,
            shaderLocation = 3,
        },
        WGPU.VertexAttribute.{
            format         = .Float32x4,
            offset         = size_of(Vector4),
            shaderLocation = 4,
        },
        WGPU.VertexAttribute.{
            format         = .Float32x4,
            offset         = size_of(Vector4) * 2,
            shaderLocation = 5,
        },
        WGPU.VertexAttribute.{
            format         = .Float32x4,
            offset         = size_of(Vector4) * 3,
            shaderLocation = 6,
        },
    ];

    instance_buffer_layout: WGPU.VertexBufferLayout = {
        stepMode       = .Instance,
        arrayStride    = size_of(Instance),
        attributeCount = instance_attributes.count,
        attributes     = instance_attributes.data,
    };

    vertex_state_buffers := WGPU.VertexBufferLayout.[vertex_buffer_layout, instance_buffer_layout];

    vertex_state: WGPU.VertexState = {
        module      = shader_module,
        entryPoint  = WGPU.to_string_view("vs_main"),
        bufferCount = vertex_state_buffers.count,
        buffers     = vertex_state_buffers.data,
    };

    // =========================================================================
    // Primitive state
    // =========================================================================

    primitive_state: WGPU.PrimitiveState = {
        topology         = .TriangleList,
        stripIndexFormat = .Undefined,
        frontFace        = .CCW,
        cullMode         = .Back,
    };

    // =========================================================================
    // Multisample state
    // =========================================================================

    multisample_state: WGPU.MultisampleState = {
        count = 1,
        mask  = ~cast(u32, 0),
    };

    // =========================================================================
    // Fragment state
    // =========================================================================

    blend_state: WGPU.BlendState = {
        color = {
            operation =  .Add,
            srcFactor = .SrcAlpha,
            dstFactor = .OneMinusSrcAlpha,
        },
        alpha = {
            operation = .Add,
            srcFactor = .Zero,
            dstFactor = .One,
        },
    };

    color_target_state: WGPU.ColorTargetState = {
        format = texture_format,
        blend  = *blend_state,
        writeMask = WGPU.WGPUColorWriteMask_All,
    };

    fragment_state: WGPU.FragmentState = {
        module      = shader_module,
        entryPoint  = WGPU.to_string_view("fs_main"),
        targetCount = 1,
        targets     = *color_target_state,
    };

    pipeline_layout_descriptor: WGPU.PipelineLayoutDescriptor = {
        bindGroupLayoutCount = cast(u32, bind_group_layouts.count),
        bindGroupLayouts     = bind_group_layouts.data,
    };

    pipeline_layout := WGPU.DeviceCreatePipelineLayout(device, *pipeline_layout_descriptor);
    defer WGPU.PipelineLayoutRelease(pipeline_layout);

    descriptor: WGPU.RenderPipelineDescriptor = {
        label       = WGPU.to_string_view("Model Render Pipeline"),
        layout      = pipeline_layout,
        vertex      = vertex_state,
        primitive   = primitive_state,
        multisample = multisample_state,
        fragment    = *fragment_state,
    };

    return WGPU.DeviceCreateRenderPipeline(device, *descriptor);
}

update_transforms :: (renderer: *Renderer, camera: $T/interface Render_Camera) {
    width  := renderer.wgpu_toolbox.surface_configuration.width;
    height := renderer.wgpu_toolbox.surface_configuration.height;

    renderer.transforms.projection = make_projection_matrix(
        camera.fov_radians,
        cast(float, width) / cast(float, height),
        camera.z_near,
        camera.z_far,
        depth_range_01 = true,
    );

    renderer.transforms.view = make_look_at_matrix(
        camera.position,
        camera.target,
        camera.up,
        x_is_forward = false,
    );

    column_major_matrices: Transforms = {
        projection = transpose(renderer.transforms.projection),
        view = transpose(renderer.transforms.view),
    };

    WGPU.QueueWriteBuffer(
        renderer.wgpu_toolbox.queue,
        renderer.transforms_uniform.buffer,
        0,
        *column_major_matrices,
        size_of(Transforms),
    );
}

handle_framebuffer_size_change :: (width: u32, height: u32, data: *void) {
    renderer := cast(*Renderer, data);

    using renderer.wgpu_toolbox;

    renderer.wgpu_toolbox.surface_configuration = configure_wgpu_surface(surface, device, surface_capabilities, width, height);
}

#import "Basic";
#import "Math";
#import "String";
#import "Hash_Table";
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
#load "model.jai";
