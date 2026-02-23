X11_Window  :: #type u64;
X11_Display :: #type *void;

get_x11_window  :: (window: *Window) -> X11_Window #foreign GLFW "glfwGetX11Window";
get_x11_display :: () -> X11_Display #foreign GLFW "glfwGetX11Display";
