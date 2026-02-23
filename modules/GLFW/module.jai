DONT_CARE: s32 : -1;

#if OS == .WINDOWS {
    #load "windows.jai";
}

Error_Proc            :: #type (code: s32, description: *u8) #c_call;
Framebuffer_Size_Proc :: #type (window: *Window, width: s32, height: s32) #c_call;
Cursor_Position_Proc  :: #type (window: *Window, x: float64, y: float64) #c_call;
Scroll_Proc           :: #type (window: *Window, x_offset: float64, y_offset: float64) #c_call;
Key_Proc              :: #type (window: *Window, key: Key, scan_code: s32, action: Key_State, mods: s32) #c_call;
Window_Size_Proc      :: #type (window: *Window, width: s32, height: s32) #c_call;
Window_Position_Proc  :: #type (window: *Window, x: s32, y: s32) #c_call;

Window  :: struct {};
Monitor :: struct {};

Video_Mode :: struct {
    width:  u32;
    height: u32;

    refresh_rate: s32;
};

Window_Hint :: enum #specified {
    CONTEXT_VERSION_MAJOR        :: 0x00022002;
    CONTEXT_VERSION_MINOR        :: 0x00022003;
    OPENGL_PROFILE               :: 0x00022008;
    OPENGL_FORWARD_COMPATIBILITY :: 0x00022006;
    SRGB_CAPABLE                 :: 0x0002100E;
    CLIENT_API                   :: 0x00022001;
    DEPTH_BITS                   :: 0x00021005;
    STENCIL_BITS                 :: 0x00021006;
};

OpenGL_Profile :: enum #specified {
    CORE :: 0x00032001;
};

Client_API :: enum #specified {
    NO_API :: 0;
}

Key :: enum #specified {
    SPACE :: 32;

    MINUS     :: 45;
    PERIOD    :: 46;
    SLASH     :: 47;
    ZERO      :: 48;
    ONE       :: 49;
    TWO       :: 50;
    THREE     :: 51;
    FOUR      :: 52;
    FIVE      :: 53;
    SIX       :: 54;
    SEVEN     :: 55;
    EIGHT     :: 56;
    NINE      :: 57;
    SEMICOLON :: 59;
    EQUAL     :: 61;

    A :: 65;
    B :: 66;
    C :: 67;
    D :: 68;
    E :: 69;
    F :: 70;
    G :: 71;
    H :: 72;
    I :: 73;
    J :: 74;
    K :: 75;
    L :: 76;
    M :: 77;
    N :: 78;
    O :: 79;
    P :: 80;
    Q :: 81;
    R :: 82;
    S :: 83;
    T :: 84;
    U :: 85;
    V :: 86;
    W :: 87;
    X :: 88;
    Y :: 89;
    Z :: 90;

    ESCAPE :: 256;

    ARROW_RIGHT :: 262;
    ARROW_LEFT  :: 263;
    ARROW_DOWN  :: 264;
    ARROW_UP    :: 265;

    F1  :: 290;
    F2  :: 291;
    F3  :: 292;
    F4  :: 293;
    F5  :: 294;
    F6  :: 295;
    F7  :: 296;
    F8  :: 297;
    F9  :: 298;
    F10 :: 299;
    F11 :: 300;
    F12 :: 301;
}

Key_State :: enum #specified {
    RELEASE :: 0;
    PRESS   :: 1;
    REPEAT  :: 2;
}

Input_Mode :: enum #specified {
    CURSOR :: 0x00033001;
}

Input_Mode_Value :: enum #specified {
    CURSOR_NORMAL   :: 0x00034001;
    CURSOR_DISABLED :: 0x00034003;
}

init :: inline () -> bool {
    result := glfwInit();

    return result == GLFW_TRUE; 
}

terminate :: () #foreign GLFW "glfwTerminate";

set_window_hint :: inline (hint: Window_Hint, value: s32) {
    glfwWindowHint(xx hint, value);
}

get_window_user_pointer :: (window: *Window) -> *void #foreign GLFW "glfwGetWindowUserPointer";

set_window_user_pointer :: (
    window: *Window,
    pointer: *void,
) #foreign GLFW "glfwSetWindowUserPointer";

set_window_hint :: inline (hint: Window_Hint, value: bool) {
    glfwWindowHint(xx hint, xx value);
}

set_window_hint :: inline (hint: Window_Hint, value: OpenGL_Profile) {
    glfwWindowHint(xx hint, xx value);
}

set_window_hint :: inline (hint: Window_Hint, value: Client_API) {
    glfwWindowHint(xx hint, xx value);
}

set_swap_interval :: (frames_to_wait: s32) #foreign GLFW "glfwSwapInterval";

get_primary_monitor :: () -> *Monitor #foreign GLFW "glfwGetPrimaryMonitor";

get_video_mode :: inline (monitor: *Monitor) -> Video_Mode {
    video_mode := glfwGetVideoMode(monitor);

    return {
        width  = xx video_mode.width,
        height = xx video_mode.height,
        refresh_rate = video_mode.refresh_rate,
    };
}

get_window_position :: (window: *Window) -> x: s32, y: s32 {
    x, y: s32;
    glfwGetWindowPos(window, *x, *y);

    return x, y;
}

create_window :: inline (
    width:   u32,
    height:  u32,
    $$title: string,
    monitor: *Monitor = null,
    share:   *Window = null
) -> *Window {
    #if is_constant(title) {
        return glfwCreateWindow(
            xx width,
            xx height,
            title.data,
            monitor,
            share
        );
    }

    c_title := to_c_string(title);
    defer free(c_title);
    return glfwCreateWindow(xx width, xx height, c_title, monitor, share);
}

should_window_close :: inline (window: *Window) -> bool {
    return xx glfwWindowShouldClose(window);
}

swap_buffers :: (window: *Window) #foreign GLFW "glfwSwapBuffers";

poll_events :: () #foreign GLFW "glfwPollEvents";

destroy_window :: (window: *Window) #foreign GLFW "glfwDestroyWindow";

focus_window :: (window: *Window) #foreign GLFW "glfwFocusWindow";

set_error_callback :: (
    callback: Error_Proc
) #foreign GLFW "glfwSetErrorCallback";

make_context_current :: (
    window: *Window
) #foreign GLFW "glfwMakeContextCurrent";

get_proc_address :: (
    procedure_name: *u8
) -> *void #foreign GLFW "glfwGetProcAddress";

set_framebuffer_size_callback :: (
    window: *Window,
    callback: Framebuffer_Size_Proc
) #foreign GLFW "glfwSetFramebufferSizeCallback";

get_key :: (
    window: *Window,
    key: Key
) -> Key_State #foreign GLFW "glfwGetKey";

get_time :: () -> float64 #foreign GLFW "glfwGetTime";

set_input_mode :: inline (
    window: *Window,
    mode: Input_Mode,
    value: Input_Mode_Value
) {
    glfwSetInputMode(window, xx mode, xx value);
};

set_cursor_position_callback :: (
    window: *Window,
    callback: Cursor_Position_Proc
) #foreign GLFW "glfwSetCursorPosCallback";

set_scroll_callback :: (
    window: *Window,
    callback: Scroll_Proc
) #foreign GLFW "glfwSetScrollCallback";

set_key_callback :: (
    window: *Window,
    callback: Key_Proc
) #foreign GLFW "glfwSetKeyCallback";

set_window_size_callback :: (
    window: *Window,
    callback: Window_Size_Proc,
) #foreign GLFW "glfwSetWindowSizeCallback";

set_window_position_callback :: (
    window: *Window,
    callback: Window_Position_Proc,
) #foreign GLFW "glfwSetWindowPosCallback";

get_cursor_position :: (window: *Window) -> float, float {
    x, y: float64;

    glfwGetCursorPos(window, *x, *y);

    return xx x, xx y;
}

get_framebuffer_size :: (window: *Window) -> width: u32, height: u32 {
    width, height: s32;
    glfwGetFramebufferSize(window, *width, *height);

    return cast(u32, width), cast(u32, height);
}

get_window_size :: (window: *Window) -> width: u32, height: u32 {
    width, height: s32;
    glfwGetWindowSize(window, *width, *height);

    return cast(u32, width), cast(u32, height);
}

set_cursor_position :: (
    window: *Window,
    x: float64,
    y: float64
) #foreign GLFW "glfwSetCursorPos";

set_window_monitor :: inline (
    window: *Window,
    monitor: *Monitor,
    x: s32,
    y: s32,
    width: u32,
    height: u32,
    refresh_rate: s32,
) {
    glfwSetWindowMonitor(
        window,
        monitor,
        x,
        y,
        cast(s32, width),
        cast(s32, height),
        refresh_rate,
    );
}

set_window_size :: inline (
    window: *Window,
    width: u32,
    height: u32,
) {
    glfwSetWindowSize(
        window,
        cast(s32, width),
        cast(s32, height),
    );
}



#scope_module

GLFWvidmode :: struct {
    width:  s32;
    height: s32;

    red_bits:   s32;
    green_bits: s32;
    blue_bits:  s32;

    refresh_rate: s32;
}

GLFW_TRUE:  s32 : 1;
GLFW_FALSE: s32 : 0;

glfwInit :: () -> s32 #foreign GLFW;

glfwWindowHint :: (hint: s32, value: s32) #foreign GLFW;

glfwCreateWindow :: (
    width:   s32,
    height:  s32,
    title:   *u8,
    monitor: *Monitor,
    share:   *Window
) -> *Window #foreign GLFW;

glfwWindowShouldClose :: (window: *Window) -> s32 #foreign GLFW;

glfwSetInputMode :: (window: *Window, mode: s32, value: s32) #foreign GLFW;
glfwGetCursorPos :: (window: *Window, x: *float64, y: *float64) #foreign GLFW;

glfwGetVideoMode :: (monitor: *Monitor) -> *GLFWvidmode #foreign GLFW;

glfwSetWindowMonitor :: (
    window: *Window,
    monitor: *Monitor,
    x: s32,
    y: s32,
    width: s32,
    height: s32,
    refresh_rate: s32,
) #foreign GLFW;

glfwSetWindowSize :: (
    window: *Window,
    width: s32,
    height: s32,
) #foreign GLFW;

glfwGetFramebufferSize :: (
    window: *Window,
    width: *s32,
    height: *s32
) #foreign GLFW "glfwGetFramebufferSize";

glfwGetWindowSize :: (window: *Window, width: *s32, height: *s32) #foreign GLFW;

glfwGetWindowPos :: (window: *Window, x: *s32, y: *s32) #foreign GLFW;

#if OS == {
    case .MACOS;
        GLFW :: #library,no_dll "macos/libglfw3";
        #library,system,link_always "IOKit";
    case .WINDOWS;
        GLFW :: #library,no_dll "windows/Release/glfw3";
        #library,system,link_always "user32";
        #library,system,link_always "gdi32";
        #library,system,link_always "shell32";
    case .LINUX;
        GLFW :: #library,no_dll "linux/libglfw3";
        #library,system,link_always "libm";
}

#import "Basic";
