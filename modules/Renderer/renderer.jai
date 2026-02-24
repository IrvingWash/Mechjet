Renderer_Handle :: #type *void;

init_renderer :: (window: Window.Window_Handle) -> ok: bool, Renderer_Handle {
    renderer := New(Renderer);

    renderer.window = window;

    init_wgpu(renderer.window);

    return true, renderer;
}

deinit_renderer :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

    // @Incomplete

    free(renderer);
}



#scope_file

Renderer :: struct {
    window: Window.Window_Handle;
}

#import "Basic";
WGPU :: #import "WGPU";
Window :: #import "Window";
#load "wgpu_helpers.jai";
