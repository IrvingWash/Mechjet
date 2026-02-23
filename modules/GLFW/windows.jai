HWND    :: struct {};

get_win32_window :: (window: *Window) -> *HWND #foreign GLFW "glfwGetWin32Window";
