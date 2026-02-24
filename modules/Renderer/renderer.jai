Renderer_Handle :: #type *void;

init_renderer :: (window: Window.Window_Handle) -> ok: bool, Renderer_Handle {
    renderer := New(Renderer);

    renderer.window = window;

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



#scope_file

Renderer :: struct {
    window:       Window.Window_Handle;
    wgpu_toolbox: WGPU_Toolbox;
}

#import "Basic";
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
