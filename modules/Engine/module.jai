#module_parameters()(DEBUG := false);

// =============================================================================
// Engine lifecycle
// =============================================================================

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

    engine.asset_storage = init_asset_storage();

    return true;
}

deinit :: () {
    deinit_asset_storage(engine.asset_storage);

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

// =============================================================================
// Rendering
// =============================================================================

// @Todo maybe call this in begin frame?
start_drawing :: inline (camera: $T/interface Renderer.Render_Camera) {
    Renderer.start_drawing(engine.renderer, camera);
}

draw_model :: inline (model: Renderer.Model, transform: Matrix4) {
    Renderer.draw_model(engine.renderer, model, transform);
}

// @Todo maybe have something like end_frame and put this there?
end_drawing :: inline () {
    Renderer.end_drawing(engine.renderer);
}

// =============================================================================
// Assets
// =============================================================================

get_model_handle :: inline (path: string) -> ok: bool, handle: Model_Handle {
    ok, handle := get_model_handle_from_storage(engine.asset_storage, engine.renderer, path);

    return ok, handle;
}

resolve_model_handle :: inline (handle: Model_Handle) -> Renderer.Model {
    return resolve_model_handle_in_storage(engine.asset_storage, handle);
}

// =============================================================================
// Math
// =============================================================================

get_scroll_delta :: inline () -> Vector2 {
    return get_scroll_delta(engine.input_state);
}

get_cursor_delta :: inline () -> Vector2 {
    return get_cursor_delta(engine.input_state);
}

is_key_pressed :: inline (key: Key) -> bool {
    return is_key_pressed(engine.input_state, key);
}

is_key_held :: inline (key: Key) -> bool {
    return is_key_held(engine.input_state, key);
}

// =============================================================================
// Math
// =============================================================================

deg_to_rad :: (degrees: float) -> float {
    return degrees * PI_BY_HALF_CIRCLE;
}



#scope_file

PI_BY_HALF_CIRCLE :: PI / 180.0;

Engine :: struct {
    window: Window.Window_Handle;
    input_state: Input_State_Handle;
    renderer: Renderer.Renderer_Handle;
    asset_storage: Asset_Storage_Handle;
}

engine: Engine;

#import "Basic";
#import "Math";
Window   :: #import "Window";
Renderer :: #import "Renderer";

#load "input.jai";
#load "asset_storage.jai";
