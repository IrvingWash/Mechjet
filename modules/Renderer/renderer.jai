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

    using renderer.wgpu_toolbox;

    renderer.transforms_bind_group_layout = create_transforms_bind_group_layout(device);
    renderer.material_bind_group_layout = create_material_bind_group_layout(device);

    renderer.pipelines.single_sided_model = create_model_render_pipeline(
        device,
        surface_configuration.format,
        .[
            renderer.transforms_bind_group_layout,
            renderer.material_bind_group_layout,
        ],
        cull_faces = true,
    );
    renderer.pipelines.double_sided_model = create_model_render_pipeline(
        device,
        surface_configuration.format,
        .[
            renderer.transforms_bind_group_layout,
            renderer.material_bind_group_layout,
        ],
        cull_faces = false,
    );

    renderer.transforms_uniform = create_transforms_uniform(
        device,
        renderer.transforms_bind_group_layout,
    );

    ok, renderer.default_base_color_texture = create_base_color_texture(
        renderer,
        path_join(#filepath, "assets/textures/default.png",, temp),
        .ClampToEdge,
        .ClampToEdge,
        .Linear,
        .Nearest,
    );
    assert(ok, "Failed to create default base color texture");

    renderer.depth_texture = create_depth_texture(
        renderer,
        {
            width              = surface_configuration.width,
            height             = surface_configuration.height,
            depthOrArrayLayers = 1,
        },
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

    destroy_texture(renderer.default_base_color_texture);
    destroy_texture(renderer.depth_texture);

    for batch: renderer.batches {
        array_free(batch.instances);
        WGPU.BufferRelease(batch.instance_buffer);
        release_uniform(batch.material_uniform);
    }
    table_reset(*renderer.batches);
    deinit(*renderer.batches);

    Window.remove_framebuffer_size_change_handler(renderer.window, handle_framebuffer_size_change);

    WGPU.RenderPipelineRelease(renderer.pipelines.single_sided_model);
    WGPU.RenderPipelineRelease(renderer.pipelines.double_sided_model);
    WGPU.BindGroupLayoutRelease(renderer.transforms_bind_group_layout);
    WGPU.BindGroupLayoutRelease(renderer.material_bind_group_layout);

    release_uniform(renderer.transforms_uniform);

    deinit_wgpu(renderer.wgpu_toolbox);

    free(renderer);
}

start_drawing :: (handle: Renderer_Handle, camera: Render_Camera) {
    renderer := cast(*Renderer, handle);

    update_transforms(renderer, camera);

    for *batch: renderer.batches {
        array_reset_keeping_memory(*batch.instances);
    }
}

draw_model :: (handle: Renderer_Handle, model: Model, transform: Matrix4, tint: Vector4) {
    renderer := cast(*Renderer, handle);

    for node: model.nodes {
        if node.parent_index == -1 {
            schedule_node_for_drawing(renderer, node, model, transform, tint);
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

    transforms: Transforms;

    pipelines: Pipelines;

    transforms_bind_group_layout: WGPU.BindGroupLayout;
    material_bind_group_layout: WGPU.BindGroupLayout;

    transforms_uniform:    Uniform;

    batches: Table(u64, Batch);

    default_base_color_texture: Texture;
    depth_texture:              Texture;
}



#scope_file

Pipelines :: struct {
    single_sided_model: WGPU.RenderPipeline;
    double_sided_model: WGPU.RenderPipeline;
}

Batch :: struct {
    mesh:             Mesh;
    instances:        [..]Instance;
    instance_buffer:  WGPU.Buffer;
    material_uniform: Uniform;
}

Instance :: struct {
    column_major_transform: Matrix4;

    tint: Vector4 = { 1, 1, 1, 1 };
} @GPU

Transforms :: struct {
    projection: Matrix4;
    view:       Matrix4;
} @GPU

Uniform :: struct {
    bind_group:        WGPU.BindGroup;
    buffer:            WGPU.Buffer;
}

schedule_node_for_drawing :: (renderer: *Renderer, node: Node, model: Model, parent_transform: Matrix4, tint: Vector4) {
    using renderer.wgpu_toolbox;

    transform := parent_transform * node.local_transform;

    if node.mesh_count > 0 {
        for node.first_mesh_index..(cast(s64, node.first_mesh_index) + node.mesh_count - 1) {
            mesh := model.meshes[it];

            instance: Instance = {
                column_major_transform = transpose(transform),
                tint = tint,
            };

            batch := table_find_pointer(*renderer.batches, xx mesh.vertex_buffer);
            if batch {
                array_add(*batch.instances, instance);
            } else {
                new_batch: Batch = {
                    mesh = mesh,
                    instance_buffer = create_instance_buffer(device, 1),
                    material_uniform = create_material_uniform(
                        renderer,
                        mesh.material,
                        renderer.material_bind_group_layout,
                    ),
                };

                array_add(*new_batch.instances, instance);

                table_set(*renderer.batches, xx mesh.vertex_buffer, new_batch);
            }
        }
    }

    for child_index: node.children_indices {
        schedule_node_for_drawing(renderer, model.nodes[child_index], model, transform, tint);
    }
}


do_main_pass :: (
    renderer:        *Renderer,
    command_encoder: WGPU.CommandEncoder,
    texture_view:    WGPU.TextureView,
) {
    using renderer.wgpu_toolbox;

    color_attachment: WGPU.RenderPassColorAttachment = {
        view       = texture_view,
        loadOp     = .Clear,
        storeOp    = .Store,
        clearValue = WGPU.to_wgpu_color(renderer.clear_color),
        depthSlice = WGPU.DEPTH_SLICE_UNDEFINED,
    };

    depth_stencil_attachment: WGPU.RenderPassDepthStencilAttachment = {
        view            = renderer.depth_texture.view,
        depthLoadOp     = .Clear,
        depthStoreOp    = .Store,
        depthClearValue = 1,
        depthReadOnly   = xx false,
    };

    render_pass_descriptor: WGPU.RenderPassDescriptor = {
        colorAttachmentCount   = 1,
        colorAttachments       = *color_attachment,
        depthStencilAttachment = *depth_stencil_attachment,
    };

    render_pass_encoder := WGPU.CommandEncoderBeginRenderPass(command_encoder, *render_pass_descriptor);
    defer WGPU.RenderPassEncoderRelease(render_pass_encoder);

    WGPU.RenderPassEncoderSetBindGroup(render_pass_encoder, 0, renderer.transforms_uniform.bind_group, 0, null);

    for *batch: renderer.batches {
        if batch.instances.count == 0 {
            continue;
        }

        if batch.mesh.material.double_sided {
            WGPU.RenderPassEncoderSetPipeline(render_pass_encoder, renderer.pipelines.double_sided_model);
        } else {
            WGPU.RenderPassEncoderSetPipeline(render_pass_encoder, renderer.pipelines.single_sided_model);
        }

        batch_size := batch.instances.count * size_of(Instance);

        if cast(u64, batch_size) > WGPU.BufferGetSize(batch.instance_buffer) {
            WGPU.BufferRelease(batch.instance_buffer);

            batch.instance_buffer = create_instance_buffer(
                device,
                cast(u32, batch.instances.count * 1.5), // Overallocate 1.5x.
            );
        }

        WGPU.RenderPassEncoderSetBindGroup(
            render_pass_encoder,
            1,
            batch.material_uniform.bind_group,
            0,
            null,
        );

        WGPU.QueueWriteBuffer(
            queue,
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

create_transforms_bind_group_layout :: (device: WGPU.Device) -> WGPU.BindGroupLayout {
    entry: WGPU.BindGroupLayoutEntry = {
        binding    = 0,
        visibility = WGPU.WGPUShaderStage_Vertex,
        buffer     = WGPU.BufferBindingLayout.{
            type             = .Uniform,
            minBindingSize   = size_of(Transforms),
            hasDynamicOffset = xx false,
        },
    };

    descriptor: WGPU.BindGroupLayoutDescriptor = {
        entryCount = 1,
        entries    = *entry,
    };

    return WGPU.DeviceCreateBindGroupLayout(device, *descriptor);
}

create_transforms_uniform :: (device: WGPU.Device, bind_group_layout: WGPU.BindGroupLayout) -> Uniform {
    uniform: Uniform;

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
            layout     = bind_group_layout,
            entryCount = 1,
            entries    = *entry,
        };

        uniform.bind_group = WGPU.DeviceCreateBindGroup(device, *group_descriptor);
    }

    return uniform;
}

create_material_bind_group_layout :: (device: WGPU.Device) -> WGPU.BindGroupLayout {
    entries := WGPU.BindGroupLayoutEntry.[
        {
            binding    = 0,
            visibility = WGPU.WGPUShaderStage_Fragment,
            buffer     = WGPU.BufferBindingLayout.{
                type             = .Uniform,
                hasDynamicOffset = xx false,
                minBindingSize   = size_of(Material.Params),
            },
        },
        {
            binding    = 1,
            visibility = WGPU.WGPUShaderStage_Fragment,
            texture    = WGPU.TextureBindingLayout.{
                sampleType    = .Float,
                viewDimension = ._2D,
                multisampled  = xx false,
            },
        },
        {
            binding    = 2,
            visibility = WGPU.WGPUShaderStage_Fragment,
            sampler    = WGPU.SamplerBindingLayout.{
                type = .Filtering,
            },
        }
    ];

    descriptor := WGPU.BindGroupLayoutDescriptor.{
        label      = WGPU.to_string_view("Material Bind Group Layout Descriptor"),
        entryCount = entries.count,
        entries    = entries.data,
    };

    return WGPU.DeviceCreateBindGroupLayout(device, *descriptor);
}

create_material_uniform :: (renderer: *Renderer, material: Material, bind_group_layout: WGPU.BindGroupLayout) -> Uniform {
    using renderer.wgpu_toolbox;

    uniform: Uniform;

    { // Buffer
        buffer_descriptor := WGPU.BufferDescriptor.{
            usage            = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Uniform,
            size             = WGPU.to_copy_buffer_alignment(size_of(Material.Params)),
            mappedAtCreation = xx false,
        };

        uniform.buffer = WGPU.DeviceCreateBuffer(device, *buffer_descriptor);

        WGPU.QueueWriteBuffer(
            queue,
            uniform.buffer,
            0,
            *material.params.base_color_factor,
            size_of(Material.Params),
        );
    }

    { // Bind group
        base_color_texture := ifx material.base_color_texture.texture
            then material.base_color_texture
            else renderer.default_base_color_texture;

        entries := WGPU.BindGroupEntry.[
            {
                binding = 0,
                buffer  = uniform.buffer,
                offset  = 0,
                size    = size_of(Material.Params),
            },
            {
                binding = 1,
                textureView = base_color_texture.view,
            },
            {
                binding = 2,
                sampler = base_color_texture.sampler,
            },
        ];

        group_descriptor: WGPU.BindGroupDescriptor = {
            label      = WGPU.to_string_view("Material Bind Group"),
            layout     = bind_group_layout,
            entryCount = entries.count,
            entries    = entries.data,
        };

        uniform.bind_group = WGPU.DeviceCreateBindGroup(device, *group_descriptor);
    }

    return uniform;
}

release_uniform :: (uniform: Uniform) {
    WGPU.BufferRelease(uniform.buffer);

    WGPU.BindGroupRelease(uniform.bind_group);
}

create_model_render_pipeline :: (
    device: WGPU.Device,
    texture_format: WGPU.TextureFormat,
    bind_group_layouts: []WGPU.BindGroupLayout,
    cull_faces: bool,
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

        // Tint
        WGPU.VertexAttribute.{
            format         = .Float32x4,
            offset         = size_of(Matrix4),
            shaderLocation = 7,
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
        cullMode         = ifx cull_faces
            then.Back
            else .None,
    };

    // =========================================================================
    // Depth stencil state
    // =========================================================================

    depth_stencil_state: WGPU.DepthStencilState = {
        format              = .Depth32Float,
        depthWriteEnabled   = xx true,
        depthCompare        = .Less,
        depthBias           = 0,
        depthBiasSlopeScale = 0,
        depthBiasClamp      = 0,
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
        label        = WGPU.to_string_view("Model Render Pipeline"),
        layout       = pipeline_layout,
        vertex       = vertex_state,
        primitive    = primitive_state,
        depthStencil = *depth_stencil_state,
        multisample  = multisample_state,
        fragment     = *fragment_state,
    };

    return WGPU.DeviceCreateRenderPipeline(device, *descriptor);
}

update_transforms :: (renderer: *Renderer, camera: Render_Camera) {
    using renderer.wgpu_toolbox;

    width  := surface_configuration.width;
    height := surface_configuration.height;

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
        queue,
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

    destroy_texture(renderer.depth_texture);
    renderer.depth_texture = create_depth_texture(
        renderer,
        {
            width              = surface_configuration.width,
            height             = surface_configuration.height,
            depthOrArrayLayers = 1,
        },
    );
}

#import "Basic";
#import "Math";
#import "String";
#import "Hash_Table";
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
