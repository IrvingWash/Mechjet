#module_parameters()(DEBUG := false);

init :: (
    title: string,
    window_width: u32,
    window_height: u32,
    clear_color: Vector4 = { 0, 0, 1, 1 },
) -> ok: bool {
    ok:, engine.window = Window.create_window(title, window_width, window_height);
    if !ok {
        log_error("Failed to create window");
        return false;
    }

    engine.input_state = init_input(engine.window);

    ok, engine.renderer = Renderer.init_renderer(engine.window, clear_color);
    if !ok {
        log_error("Failed to initialize renderer");
        return false;
    }

    return true;
}

deinit :: () {
    Renderer.deinit_renderer(engine.renderer);

    deinit_input(engine.input_state);

    Window.destroy_window(engine.window);
}

begin_frame :: () {
    process_input(engine.input_state);
}

should_quit :: inline () -> bool {
    return Window.should_window_close(engine.window);
}

// @Todo maybe call this in begin frame?
start_drawing :: inline (camera: $T/interface Renderer.Render_Camera) {
    Renderer.start_drawing(engine.renderer, camera);
}

// @Todo maybe have something like end_frame and put this there?
end_drawing :: inline () {
    Renderer.end_drawing(engine.renderer);
}

deg_to_rad :: (degrees: float) -> float {
    return degrees * PI_BY_HALF_CIRCLE;
}



#scope_file

PI_BY_HALF_CIRCLE :: PI / 180.0;

Engine :: struct {
    window: Window.Window_Handle;
    input_state: Input_State_Handle;
    renderer: Renderer.Renderer_Handle;
}

engine: Engine;

#import "Basic";
#import "Math";
Window   :: #import "Window";
Renderer :: #import "Renderer";

#load "input.jai";
