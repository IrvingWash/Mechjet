Renderer_Handle :: #type *void;

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

    renderer.triangle_render_pipeline = create_triangle_render_pipeline(
        renderer.wgpu_toolbox.device,
        renderer.wgpu_toolbox.surface_configuration.format,
    ); // @no_merge

    renderer.triangle_mesh = create_triangle_mesh(
        renderer.wgpu_toolbox.device,
        renderer.wgpu_toolbox.queue,
    ); // @no_merge

    return true, renderer;
}

deinit_renderer :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

    WGPU.BufferRelease(renderer.triangle_mesh.index_buffer); // @no_merge
    WGPU.BufferRelease(renderer.triangle_mesh.vertex_buffer); // @no_merge

    WGPU.RenderPipelineRelease(renderer.triangle_render_pipeline); // @no_merge

    deinit_wgpu(renderer.wgpu_toolbox);

    free(renderer);
}

start_drawing :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);
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

    do_backbuffer_pass(command_encoder, surface_texture_view, renderer);

    command_buffer := WGPU.CommandEncoderFinish(command_encoder, null);
    defer WGPU.CommandBufferRelease(command_buffer);

    WGPU.QueueSubmit(queue, 1, *command_buffer);

    WGPU.SurfacePresent(surface);
}



#scope_file

do_backbuffer_pass :: (
    command_encoder: WGPU.CommandEncoder,
    texture_view:    WGPU.TextureView,
    renderer:        *Renderer,
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

    WGPU.RenderPassEncoderSetPipeline(render_pass_encoder, renderer.triangle_render_pipeline); // @no_merge

    // @no_merge
    WGPU.RenderPassEncoderSetVertexBuffer(render_pass_encoder, 0, renderer.triangle_mesh.vertex_buffer, 0, WGPU.BufferGetSize(renderer.triangle_mesh.vertex_buffer));
    WGPU.RenderPassEncoderSetIndexBuffer(render_pass_encoder, renderer.triangle_mesh.index_buffer, .Uint16, 0, WGPU.BufferGetSize(renderer.triangle_mesh.index_buffer));

    WGPU.RenderPassEncoderDrawIndexed(render_pass_encoder, renderer.triangle_mesh.index_count, 1, 0, 0, 0); // @no_merge

    WGPU.RenderPassEncoderEnd(render_pass_encoder);
}

create_triangle_render_pipeline :: (device: WGPU.Device, texture_format: WGPU.TextureFormat) -> WGPU.RenderPipeline { // @no_merge
    ok, shader_module := create_wgpu_shader_module(
        device,
        path_join(#filepath, "assets/shaders/triangle.wgsl",, temp),
    );
    assert(ok);
    defer WGPU.ShaderModuleRelease(shader_module);

    vertex_attributes := WGPU.VertexAttribute.[
        WGPU.VertexAttribute.{
            format         = .Float32x3,
            offset         = 0,
            shaderLocation = 0,
        },
        WGPU.VertexAttribute.{
            format         = .Float32x3,
            offset         = size_of(Vector3),
            shaderLocation = 1,
        },
        WGPU.VertexAttribute.{
            format         = .Float32x2,
            offset         = size_of(Vector3) + size_of(Vector3),
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
        bindGroupLayoutCount = 0,
    };

    descriptor: WGPU.RenderPipelineDescriptor = {
        label       = WGPU.to_string_view("Triangle Render Pipeline"),
        layout      = WGPU.DeviceCreatePipelineLayout(device, *pipeline_layout_descriptor),
        vertex      = vertex_state,
        primitive   = primitive_state,
        multisample = multisample_state,
        fragment    = *fragment_state,
    };

    return WGPU.DeviceCreateRenderPipeline(device, *descriptor);
}

create_triangle_mesh :: (device: WGPU.Device, queue: WGPU.Queue) -> Mesh { // @no_merge
    mesh: Mesh;

    VERTICES :: Vertex.[
        {
            position = { -0.5, -0.5, 0 },
            normal = { 0, 0, 1 },
            uv     = { 0, 0 },
        },
        {
            position = { 0.5, -0.5, 0 },
            normal = { 0, 0, 1 },
            uv     = { 0, 0 },
        },
        {
            position = { 0, 0.5, 0 },
            normal = { 0, 0, 1 },
            uv     = { 0, 0 },
        },
    ];

    INDICES :: u16.[
        0, 1, 2,
    ];

    vertex_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Vertex,
        size  = WGPU.to_copy_buffer_alignment(size_of(type_of(VERTICES))),
    };
    mesh.vertex_buffer = WGPU.DeviceCreateBuffer(device, *vertex_buffer_descriptor);
    WGPU.QueueWriteBuffer(queue, mesh.vertex_buffer, 0, VERTICES.data, vertex_buffer_descriptor.size);

    index_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Index,
        size = WGPU.to_copy_buffer_alignment(size_of(type_of(INDICES))),
    };
    mesh.index_buffer = WGPU.DeviceCreateBuffer(device, *index_buffer_descriptor);
    mesh.index_count = INDICES.count;
    WGPU.QueueWriteBuffer(queue, mesh.index_buffer, 0, INDICES.data, index_buffer_descriptor.size);

    return mesh;
}

Vertex :: struct { // @no_merge
    position: Vector3;
    normal:   Vector3;
    uv:       Vector2;
}

Mesh :: struct { // @no_merge
    vertex_buffer: WGPU.Buffer;
    index_buffer:  WGPU.Buffer;
    index_count:   u32;
}

Renderer :: struct {
    window:       Window.Window_Handle;
    clear_color:  Vector4;
    wgpu_toolbox: WGPU_Toolbox;
    triangle_render_pipeline: WGPU.RenderPipeline; // @no_merge
    triangle_mesh: Mesh; // #no_merge
}

#import "Basic";
#import "Math";
#import "String"; // @no_merge
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
