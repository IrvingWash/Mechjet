#module_parameters()(DEBUG := false);

#load "math.jai";

init :: (title: string, window_width: u32, window_height: u32) -> ok: bool {
    ok:, engine.window = Window.create_window(title, window_width, window_height);
    if !ok {
        return false;
    }

    engine.input_state = Input.init_input(engine.window);

    return true;
}

deinit :: () {
    Input.deinit_input(engine.input_state);

    Window.destroy_window(engine.window);
}

begin_frame :: () {
    Input.process_input(engine.input_state);
}

should_quit :: inline () -> bool {
    return Window.should_window_close(engine.window);
}



#scope_file

Engine :: struct {
    window: Window.Window_Handle;
    input_state: *Input.Input_State_Handle;
}

engine: Engine;

#import "Basic";
Input  :: #import,file "input.jai";
Window :: #import,file "window.jai";
