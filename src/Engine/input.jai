Input_State_Handle :: #type *void;

init_input :: (window: Window.Window_Handle) -> Input_State_Handle {
    input_state := New(Input_State);
    input_state.window = window;

    Window.set_cursor_mode(input_state.window, .DISABLED);

    Window.add_scroll_handler(input_state.window, on_scroll_change, input_state);
    Window.add_cursor_position_change_handler(input_state.window, on_cursor_position_change, input_state);
    Window.add_key_handler(input_state.window, on_key, input_state);

    return input_state;
}

deinit_input :: (handle: Input_State_Handle) {
    input_state := cast(*Input_State, handle);

    Window.remove_key_handler(input_state.window, on_key);
    Window.remove_cursor_position_change_handler(input_state.window, on_cursor_position_change);
    Window.remove_scroll_handler(input_state.window, on_scroll_change);

    free(input_state);
}

is_key_held :: inline (handle: Input_State_Handle, key: Window.Key) -> bool {
    input_state := cast(*Input_State, handle);

    return Window.get_key(input_state.window, key) == Window.Key_State.PRESS;
}

is_key_pressed :: inline (handle: Input_State_Handle, key: Window.Key) -> bool {
    input_state := cast(*Input_State, handle);

    return input_state.key_state[key] == Window.Key_State.PRESS;
}

get_cursor_delta :: inline (handle: Input_State_Handle) -> Vector2 {
    input_state := cast(*Input_State, handle);

    return input_state.cursor_state.delta;
}

get_scroll_delta :: inline (handle: Input_State_Handle) -> Vector2 {
    input_state := cast(*Input_State, handle);

    return input_state.scroll_delta;
}

process_input :: (handle: Input_State_Handle) {
    input_state := cast(*Input_State, handle);

    input_state.scroll_delta = {};
    input_state.cursor_state.delta = {};
    input_state.key_state = DEFAULT_KEY_STATE;

    Window.poll_events();
}



#scope_file

Input_State :: struct {
    window: Window.Window_Handle;

    cursor_state: struct {
        previous_position: Vector2;
        delta:             Vector2;
    };

    scroll_delta: Vector2;

    key_state: [HIGHEST_KEY]Window.Key_State;
}


_, HIGHEST_KEY :: #run enum_range(Window.Key);

DEFAULT_KEY_STATE: [HIGHEST_KEY]Window.Key_State;

on_cursor_position_change: Window.Cursor_Position_Change_Handler : (
    x: float,
    y: float,
    data: *void,
) {
    input_state := cast(*Input_State, data);

    using *input_state.cursor_state;

    if previous_position.x != 0 || previous_position.y != 0 {
        delta = {
            x - previous_position.x,
            y - previous_position.y,
        };
    }

    previous_position = {
        x,
        y,
    };
}

on_scroll_change: Window.Scroll_Handler : (
    x_offset: float,
    y_offset: float,
    data: *void,
) {
    input_state := cast(*Input_State, data);

    input_state.scroll_delta = {
        x_offset,
        y_offset,
    };
}

on_key: Window.Key_Handler : (
    key: Window.Key,
    state: Window.Key_State,
    data: *void,
) {
    if key >= HIGHEST_KEY {
        return;
    }

    input_state := cast(*Input_State, data);

    input_state.key_state[key] = state;
}

#import "Basic";
#import "Math";
Window :: #import,file "window.jai";
