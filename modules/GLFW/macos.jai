NS_Window :: #type *void;
NS_View   :: #type *void;

get_cocoa_window :: (window: *Window) -> NS_Window #foreign GLFW "glfwGetCocoaWindow";
get_cocoa_view   :: (window: *Window) -> NS_View #foreign GLFW "glfwGetCocoaView";
