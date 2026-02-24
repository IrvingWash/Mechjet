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

    return true, renderer;
}

deinit_renderer :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

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

    do_backbuffer_pass(command_encoder, surface_texture_view, renderer.clear_color);

    command_buffer := WGPU.CommandEncoderFinish(command_encoder, null);
    defer WGPU.CommandBufferRelease(command_buffer);

    WGPU.QueueSubmit(queue, 1, *command_buffer);

    WGPU.SurfacePresent(surface);
}



#scope_file

do_backbuffer_pass :: (
    command_encoder: WGPU.CommandEncoder,
    texture_view: WGPU.TextureView,
    clear_color: Vector4,
) {
    render_pass_color_attachment: WGPU.RenderPassColorAttachment = {
        view       = texture_view,
        loadOp     = .Clear,
        storeOp    = .Store,
        clearValue = WGPU.Color.{ clear_color.x, clear_color.y, clear_color.z, clear_color.w },
        depthSlice = WGPU.DEPTH_SLICE_UNDEFINED,
    };

    render_pass_descriptor: WGPU.RenderPassDescriptor = {
        colorAttachmentCount = 1,
        colorAttachments     = *render_pass_color_attachment,
    };

    render_pass_encoder := WGPU.CommandEncoderBeginRenderPass(command_encoder, *render_pass_descriptor);
    defer WGPU.RenderPassEncoderRelease(render_pass_encoder);

    WGPU.RenderPassEncoderEnd(render_pass_encoder);
}

Renderer :: struct {
    window:       Window.Window_Handle;
    clear_color:  Vector4;
    wgpu_toolbox: WGPU_Toolbox;
}

#import "Basic";
#import "Math";
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
