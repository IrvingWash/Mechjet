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

    renderer.transforms.bind_group_layout,
    renderer.transforms.bind_group,
    renderer.transforms.buffer = create_transforms_bind_group(renderer.wgpu_toolbox.device);

    renderer.model_render_pipeline = create_model_render_pipeline(
        renderer.wgpu_toolbox.device,
        renderer.wgpu_toolbox.surface_configuration.format,
        renderer.transforms.bind_group_layout,
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

    array_free(renderer.models);

    Window.remove_framebuffer_size_change_handler(renderer.window, handle_framebuffer_size_change);

    WGPU.RenderPipelineRelease(renderer.model_render_pipeline);

    release_transforms_bind_group(
        renderer.transforms.bind_group_layout,
        renderer.transforms.bind_group,
        renderer.transforms.buffer,
    );

    deinit_wgpu(renderer.wgpu_toolbox);

    free(renderer);
}

start_drawing :: (handle: Renderer_Handle, camera: $T/interface Render_Camera) {
    renderer := cast(*Renderer, handle);

    update_transforms(renderer, camera);

    // @Todo array_reset_keeping memory?
    array_reset(*renderer.models); // @no_merge
}

draw_model :: (handle: Renderer_Handle, model: Model) {
    renderer := cast(*Renderer, handle);

    array_add(*renderer.models, model);
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

    do_forward_pass(renderer, command_encoder, surface_texture_view);

    command_buffer := WGPU.CommandEncoderFinish(command_encoder, null);
    defer WGPU.CommandBufferRelease(command_buffer);

    WGPU.QueueSubmit(queue, 1, *command_buffer);

    WGPU.SurfacePresent(surface);
}

// @Todo we should try to handle this better
get_toolbox :: (handle: Renderer_Handle) -> WGPU_Toolbox { // @no_merge
    renderer := cast(*Renderer, handle);

    return renderer.wgpu_toolbox;
}



#scope_module

Renderer :: struct {
    window:       Window.Window_Handle;

    clear_color:  Vector4;

    wgpu_toolbox: WGPU_Toolbox;

    transforms: Transforms;

    model_render_pipeline: WGPU.RenderPipeline;

    // @Todo this should be a table of batches
    models: [..]Model; // @no_merge
}



#scope_file

Transforms :: struct {
    matrices: Matrices;

    bind_group_layout: WGPU.BindGroupLayout;
    bind_group:        WGPU.BindGroup;
    buffer:            WGPU.Buffer;

    Matrices :: struct {
        projection: Matrix4;
        view:       Matrix4;
    }
}

do_forward_pass :: (
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

    WGPU.RenderPassEncoderSetBindGroup(render_pass_encoder, 0, renderer.transforms.bind_group, 0, null);

    // @Todo remove the hardcode!
    for model: renderer.models { // @no_merge
        WGPU.RenderPassEncoderSetVertexBuffer(
            render_pass_encoder,
            0,
            model.meshes[0].vertex_buffer,
            0,
            WGPU.BufferGetSize(model.meshes[0].vertex_buffer),
        );
        WGPU.RenderPassEncoderSetIndexBuffer(
            render_pass_encoder,
            model.meshes[0].index_buffer,
            .Uint32,
            0,
            WGPU.BufferGetSize(model.meshes[0].index_buffer),
        );

        WGPU.RenderPassEncoderDrawIndexed(render_pass_encoder, model.meshes[0].index_count, 1, 0, 0, 0);
    }

    WGPU.RenderPassEncoderEnd(render_pass_encoder);
}

create_transforms_bind_group :: (device: WGPU.Device) -> WGPU.BindGroupLayout, WGPU.BindGroup, WGPU.Buffer {
    // Bind group layout

    layout_entry: WGPU.BindGroupLayoutEntry = {
        binding    = 0,
        visibility = WGPU.WGPUShaderStage_Vertex,
        buffer     = WGPU.BufferBindingLayout.{
            type             = .Uniform,
            minBindingSize   = size_of(Transforms.Matrices),
            hasDynamicOffset = xx false,
        },
    };

    layout_descriptor: WGPU.BindGroupLayoutDescriptor = {
        entryCount = 1,
        entries    = *layout_entry,
    };

    layout := WGPU.DeviceCreateBindGroupLayout(device, *layout_descriptor);

    // Buffer

    uniform_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Uniform,
        size  = WGPU.to_copy_buffer_alignment(size_of(Transforms.Matrices)),
    };

    uniform_buffer := WGPU.DeviceCreateBuffer(device, *uniform_buffer_descriptor);

    // Bind group

    entry: WGPU.BindGroupEntry = {
        binding = 0,
        buffer = uniform_buffer,
        offset = 0,
        size = size_of(Transforms.Matrices),
    };

    group_descriptor: WGPU.BindGroupDescriptor = {
        layout     = layout,
        entryCount = 1,
        entries    = *entry,
    };

    group := WGPU.DeviceCreateBindGroup(device, *group_descriptor);

    return layout, group, uniform_buffer;
}

release_transforms_bind_group :: (layout: WGPU.BindGroupLayout, group: WGPU.BindGroup, buffer: WGPU.Buffer) {
    WGPU.BufferRelease(buffer);

    WGPU.BindGroupRelease(group);

    WGPU.BindGroupLayoutRelease(layout);
}

create_model_render_pipeline :: (device: WGPU.Device, texture_format: WGPU.TextureFormat, transforms_bind_group_layout: WGPU.BindGroupLayout) -> WGPU.RenderPipeline {
    ok, shader_module := create_wgpu_shader_module(
        device,
        path_join(#filepath, "assets/shaders/model.wgsl",, temp),
    );
    assert(ok, "Failed to load default model shader"); // @Todo handle more gracefully
    defer WGPU.ShaderModuleRelease(shader_module);

    vertex_attributes := WGPU.VertexAttribute.[
        WGPU.VertexAttribute.{
            format         = .Float32x3,
            offset         = 0,
            shaderLocation = 0,
        },
        WGPU.VertexAttribute.{
            format         = .Float32x3,
            offset         = Vertex.NORMAL_OFFSET,
            shaderLocation = 1,
        },
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

    vertex_state: WGPU.VertexState = {
        module      = shader_module,
        entryPoint  = WGPU.to_string_view("vs_main"),
        bufferCount = 1,
        buffers     = *vertex_buffer_layout,
    };

    primitive_state: WGPU.PrimitiveState = {
        topology         = .TriangleList,
        stripIndexFormat = .Undefined,
        frontFace        = .CCW,
        cullMode         = .Back,
    };

    multisample_state: WGPU.MultisampleState = {
        count = 1,
        mask  = ~cast(u32, 0),
    };

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
        bindGroupLayoutCount = 1,
        bindGroupLayouts     = *transforms_bind_group_layout,
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

    renderer.transforms.matrices.projection = make_projection_matrix(
        camera.fov_radians,
        cast(float, width) / cast(float, height),
        camera.z_near,
        camera.z_far,
        depth_range_01 = true,
    );

    renderer.transforms.matrices.view = make_look_at_matrix(
        camera.position,
        camera.target,
        camera.up,
        x_is_forward = false,
    );

    column_major_matrices: Transforms.Matrices = {
        projection = transpose(renderer.transforms.matrices.projection),
        view = transpose(renderer.transforms.matrices.view),
    };

    WGPU.QueueWriteBuffer(
        renderer.wgpu_toolbox.queue,
        renderer.transforms.buffer,
        0,
        *column_major_matrices,
        size_of(Transforms.Matrices),
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
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
#load "model.jai";
