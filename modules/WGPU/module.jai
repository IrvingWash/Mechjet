DEPTH_SLICE_UNDEFINED :: U32_MAX;

#if OS == {
    case .LINUX;
        #load "linux.jai";
        #library,system,link_always "m";
        #library,system,link_always "unwind";
        #library,system,link_always "gcc_s";
    case .MACOS;
        #load "macos.jai";
        #library,system,link_always "objc";
        #library,system,link_always "Foundation";
        #library,system,link_always "Metal";
    case .WINDOWS;
        #load "windows.jai";
        #library,system,link_always "ntdll";
        #library,system,link_always "Ws2_32";
        #library,system,link_always "Userenv";
        #library,system,link_always "Propsys";
        #library,system,link_always "Ole32";
        #library,system,link_always "User32";
        #library,system,link_always "OleAut32";
        #library,system,link_always "RuntimeObject";
        #library,system,link_always "Opengl32";
        #library,system,link_always "Gdi32";
    case;
        #assert false;
}



#scope_file

#import "Math";
