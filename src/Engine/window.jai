#scope_module

Window_Handle :: #type *void;

Key :: GLFW.Key;
Key_State :: GLFW.Key_State;

Framebuffer_Size_Change_Handler :: #type (width: u32, height: u32, data: *void);
Scroll_Handler                  :: #type (x_offset: float, y_offset: float, data: *void);
Cursor_Position_Change_Handler  :: #type (x: float, y: float, data: *void);
Key_Handler                     :: #type (key: Key, state: Key_State, data: *void);
Window_Size_Change_Handler      :: #type (width: u32, height: u32, data: *void);
Window_Position_Change_Handler  :: #type (x: s32, y: s32, data: *void);

Cursor_Mode :: enum {
    NORMAL;
    DISABLED;
}

create_window :: ($$title: string, width: u32, height: u32) -> ok: bool, Window_Handle {
    window_data := New(Window_Data);

    GLFW.set_error_callback(handle_glfw_error);

    is_glfw_initialized := GLFW.init();
    if !is_glfw_initialized {
        log_error("Failed to initialize GLFW");
        return false, null;
    };

    GLFW.set_window_hint(.CLIENT_API, .NO_API);

    window_data.window = GLFW.create_window(
        width,
        height,
        title,
    );
    if window_data.window == null {
        log_error("Failed to create a window via GLFW");
        return false, null;
    }

    { // Callbacks
        GLFW.set_framebuffer_size_callback(
            window_data.window,
            handle_framebuffer_size_change,
        );
        GLFW.set_scroll_callback(
            window_data.window,
            handle_scroll,
        );
        GLFW.set_cursor_position_callback(
            window_data.window,
            handle_cursor_position_change,
        );
        GLFW.set_key_callback(
            window_data.window,
            handle_key,
        );
        GLFW.set_window_size_callback(
            window_data.window,
            handle_window_size_change,
        );
        GLFW.set_window_position_callback(
            window_data.window,
            handle_window_position_change,
        );
    }

    { // Window data population
        framebuffer_width, framebuffer_height := GLFW.get_framebuffer_size(window_data.window);
        window_data.framebuffer_width = framebuffer_width;
        window_data.framebuffer_height = framebuffer_height;

        logical_width, logical_height := GLFW.get_window_size(window_data.window);
        window_data.logical_width = logical_width;
        window_data.logical_height = logical_height;

        x_position, y_position := GLFW.get_window_position(window_data.window);
        window_data.x_position = x_position;
        window_data.y_position = y_position;

        window_data.monitor = GLFW.get_primary_monitor();
        if window_data.monitor == null {
            log_error("Failed to get access to the monitor");
            return false, null;
        }

        window_data.video_mode = GLFW.get_video_mode(window_data.monitor);
    }

    GLFW.focus_window(window_data.window);

    GLFW.set_window_user_pointer(window_data.window, window_data);

    return true, window_data;
}

destroy_window :: (handle: Window_Handle) {
    window_data := cast(*Window_Data, handle);

    GLFW.destroy_window(window_data.window);
    GLFW.terminate();

    array_free(window_data.callbacks.framebuffer_size_change_handlers);
    array_free(window_data.callbacks.scroll_handlers);
    array_free(window_data.callbacks.cursor_position_change_handlers);
    array_free(window_data.callbacks.key_handlers);
    array_free(window_data.callbacks.window_size_change_handlers);
    array_free(window_data.callbacks.window_position_change_handlers);

    free(window_data);
}

should_window_close :: inline (handle: Window_Handle) -> bool {
    window_data := cast(*Window_Data, handle);

    return GLFW.should_window_close(window_data.window);
}

poll_events :: inline () {
    GLFW.poll_events();
}

toggle_fullscreen :: (handle: Window_Handle) {
    window_data := cast(*Window_Data, handle);

    if window_data.is_fullscreen { // Windowed
        GLFW.set_window_monitor(
            window_data.window,
            null,
            window_data.windowed_cache.x_position,
            window_data.windowed_cache.y_position,
            window_data.windowed_cache.logical_width,
            window_data.windowed_cache.logical_height,
            GLFW.DONT_CARE,
        );

        GLFW.focus_window(window_data.window);
    } else { // Fullscreen
        // Update video mode just in case
        window_data.video_mode = GLFW.get_video_mode(window_data.monitor);

        { // Cache windowed state
            x, y := GLFW.get_window_position(window_data.window);
            logical_width, logical_height := GLFW.get_window_size(window_data.window);

            window_data.windowed_cache = {
                x_position = x,
                y_position = y,
                logical_width = logical_width,
                logical_height = logical_height,
            };
        }

        GLFW.set_window_monitor(
            window_data.window,
            window_data.monitor,
            0,
            0,
            window_data.video_mode.width,
            window_data.video_mode.height,
            window_data.video_mode.refresh_rate,
        );

        GLFW.focus_window(window_data.window);
    }

    window_data.is_fullscreen = !window_data.is_fullscreen;
}

add_framebuffer_size_change_handler :: (
    handle: Window_Handle,
    handler: Framebuffer_Size_Change_Handler,
    data: *void,
) {
    window_data := cast(*Window_Data, handle);

    array_add(
        *window_data.callbacks.framebuffer_size_change_handlers,
        { proc = handler, data = data },
    );
}

remove_framebuffer_size_change_handler :: (
    handle: Window_Handle,
    handler: Framebuffer_Size_Change_Handler,
) {
    window_data := cast(*Window_Data, handle);

    for window_data.callbacks.framebuffer_size_change_handlers {
        if it.proc == handler {
            remove it;
        }
    }
}

add_scroll_handler :: (
    handle: Window_Handle,
    handler: Scroll_Handler,
    data: *void,
) {
    window_data := cast(*Window_Data, handle);

    array_add(
        *window_data.callbacks.scroll_handlers,
        { proc = handler, data = data },
    );
}

remove_scroll_handler :: (
    handle: Window_Handle,
    handler: Scroll_Handler,
) {
    window_data := cast(*Window_Data, handle);

    for window_data.callbacks.scroll_handlers {
        if it.proc == handler {
            remove it;
        }
    }
}

add_cursor_position_change_handler :: (
    handle: Window_Handle,
    handler: Cursor_Position_Change_Handler,
    data: *void
) {
    window_data := cast(*Window_Data, handle);

    array_add(
        *window_data.callbacks.cursor_position_change_handlers,
        { proc = handler, data = data },
    );
}

remove_cursor_position_change_handler :: (
    handle: Window_Handle,
    handler: Cursor_Position_Change_Handler,
) {
    window_data := cast(*Window_Data, handle);

    for window_data.callbacks.cursor_position_change_handlers {
        if it.proc == handler {
            remove it;
        }
    }
}

add_key_handler :: (
    handle: Window_Handle,
    handler: Key_Handler,
    data: *void,
) {
    window_data := cast(*Window_Data, handle);

    array_add(
        *window_data.callbacks.key_handlers,
        { proc = handler, data = data },
    );
}

remove_key_handler :: (
    handle: Window_Handle,
    handler: Key_Handler,
) {
    window_data := cast(*Window_Data, handle);

    for window_data.callbacks.key_handlers {
        if it.proc == handler {
            remove it;
        }
    }
}

add_window_size_change_handler :: (
    handle: Window_Handle,
    handler: Window_Size_Change_Handler,
    data: *void,
) {
    window_data := cast(*Window_Data, handle);

    array_add(
        *window_data.callbacks.window_size_change_handlers,
        { proc = handler, data = data },
    );
}

remove_window_size_change_handler :: (
    handle: Window_Handle,
    handler: Window_Size_Change_Handler,
) {
    window_data := cast(*Window_Data, handle);

    for window_data.callbacks.window_size_change_handlers {
        if it.proc == handler {
            remove it;
        }
    }
}

add_window_position_change_handler :: (
    handle: Window_Handle,
    handler: Window_Position_Change_Handler,
    data: *void,
) {
    window_data := cast(*Window_Data, handle);

    array_add(
        *window_data.callbacks.window_position_change_handlers,
        { proc = handler, data = data },
    );
}

remove_window_position_change_handler :: (
    handle: Window_Handle,
    handler: Window_Position_Change_Handler,
) {
    window_data := cast(*Window_Data, handle);

    for window_data.callbacks.window_position_change_handlers {
        if it.proc == handler {
            remove it;
        }
    }
}

get_framebuffer_size :: (handle: Window_Handle) -> u32, u32 {
    window_data := cast(*Window_Data, handle);

    return window_data.framebuffer_width, window_data.framebuffer_height;
}

get_key :: inline (
    handle: Window_Handle,
    key: Key,
) -> Key_State {
    window_data := cast(*Window_Data, handle);

    return GLFW.get_key(window_data.window, key);
}

set_cursor_mode :: (handle: Window_Handle, mode: Cursor_Mode) {
    window_data := cast(*Window_Data, handle);

    if mode == {
        case Cursor_Mode.NORMAL;
            GLFW.set_input_mode(window_data.window, GLFW.Input_Mode.CURSOR, GLFW.Input_Mode_Value.CURSOR_NORMAL);
        case Cursor_Mode.DISABLED;
            GLFW.set_input_mode(window_data.window, GLFW.Input_Mode.CURSOR, GLFW.Input_Mode_Value.CURSOR_DISABLED);
    }
}



#scope_file

Window_Data :: struct {
    window:  *Window;
    monitor: *Monitor;
    video_mode: Video_Mode;

    framebuffer_width: u32;
    framebuffer_height: u32;

    logical_width: u32;
    logical_height: u32;

    x_position: s32;
    y_position: s32;

    is_fullscreen: bool;

    callbacks: Callbacks;

    windowed_cache: struct {
        x_position: s32;
        y_position: s32;
        logical_width: u32;
        logical_height: u32;
    }
}

Callbacks :: struct {
    framebuffer_size_change_handlers: [..]Handler(Framebuffer_Size_Change_Handler);
    scroll_handlers: [..]Handler(Scroll_Handler);
    cursor_position_change_handlers: [..]Handler(Cursor_Position_Change_Handler);
    key_handlers: [..]Handler(Key_Handler);
    window_size_change_handlers: [..]Handler(Window_Size_Change_Handler);
    window_position_change_handlers: [..]Handler(Window_Position_Change_Handler);
}

Handler :: struct ($T: Type)
#modify {
    ti := cast(*Type_Info, T);

    return ti.type == .PROCEDURE;
}
{
    data: *void;
    proc: T;
}

Window :: #type GLFW.Window;
Monitor :: #type GLFW.Monitor;
Video_Mode :: #type GLFW.Video_Mode;

handle_glfw_error: GLFW.Error_Proc : (code: s32, description: *u8) #c_call {
    push_context {
        log_error(
            "GLFW error. Code: %, description: %",
            code,
            to_string(description,, temp),
        );
    }
}

handle_framebuffer_size_change: GLFW.Framebuffer_Size_Proc : (
    window: *GLFW.Window,
    width: s32,
    height: s32,
) #c_call {
    window_data := cast(*Window_Data, GLFW.get_window_user_pointer(window));

    window_data.framebuffer_width = cast(u32, width);
    window_data.framebuffer_height = cast(u32, height);

    push_context {
        for handler: window_data.callbacks.framebuffer_size_change_handlers {
            handler.proc(window_data.framebuffer_width, window_data.framebuffer_height, handler.data);
        }
    }
}

handle_scroll: GLFW.Scroll_Proc : (
    window: *GLFW.Window,
    x_offset: float64,
    y_offset: float64,
) #c_call {
    window_data := cast(*Window_Data, GLFW.get_window_user_pointer(window));

    push_context {
        for handler: window_data.callbacks.scroll_handlers {
            handler.proc(cast(float, x_offset), cast(float, y_offset), handler.data);
        }
    }
}

handle_cursor_position_change: GLFW.Cursor_Position_Proc : (
    window: *GLFW.Window,
    x: float64,
    y: float64,
) #c_call {
    window_data := cast(*Window_Data, GLFW.get_window_user_pointer(window));

    push_context {
        for handler: window_data.callbacks.cursor_position_change_handlers {
            handler.proc(cast(float, x), cast(float, y), handler.data);
        }
    }
}

handle_key: GLFW.Key_Proc : (
    window: *GLFW.Window,
    key: GLFW.Key,
    scan_code: s32,
    action: GLFW.Key_State,
    mods: s32,
) #c_call {
    window_data := cast(*Window_Data, GLFW.get_window_user_pointer(window));

    push_context {
        for handler: window_data.callbacks.key_handlers {
            handler.proc(key, action, handler.data);
        }
    }
}

handle_window_size_change: GLFW.Window_Size_Proc : (
    window: *GLFW.Window,
    width: s32,
    height: s32,
) #c_call {
    window_data := cast(*Window_Data, GLFW.get_window_user_pointer(window));

    window_data.logical_width = cast(u32, width);
    window_data.logical_height = cast(u32, height);

    push_context {
        for handler: window_data.callbacks.window_size_change_handlers {
            handler.proc(cast(u32, width), cast(u32, height), handler.data);
        }
    }
}

handle_window_position_change: GLFW.Window_Position_Proc : (
    window: *GLFW.Window,
    x: s32,
    y: s32,
) #c_call {
    window_data := cast(*Window_Data, GLFW.get_window_user_pointer(window));

    window_data.x_position = x;
    window_data.y_position = y;

    push_context {
        for handler: window_data.callbacks.window_position_change_handlers {
            handler.proc(x, y, handler.data);
        }
    }
}

#import "Basic";
GLFW :: #import "GLFW";
