Renderer_Handle :: #type *void;

init_renderer :: () -> ok: bool, Renderer_Handle {
    renderer := New(Renderer);

    init_wgpu();

    return true, renderer;
}

deinit_renderer :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

    // @Incomplete
}



#scope_file

Renderer :: struct {}

from_wgpu_string_view :: (text: WGPU.StringView) -> string {
    return {
        data  = text.data,
        count = xx text.length,
    };
}

init_wgpu :: () -> ok: bool {
    WGPU.SetLogCallback(wgpu_log_handler, null);

    instance := WGPU.CreateInstance(null);
    if instance == null {
        log_error("Failed to create WGPU Instance");
        return false;
    }
    defer WGPU.InstanceRelease(instance);

    surface := create_wgpu_surface();

    return true;
}

create_wgpu_surface :: () -> WGPU.Surface {
    #if OS == {
        case .LINUX;
        case;
            assert(false, "'%' is not supported!");
    }

    // @Incomplete
    return null;
}

wgpu_log_handler :: (
    level: WGPU.LogLevel,
    message: WGPU.StringView,
    userdata: *void,
) #c_call {
    push_context {
        log(
            "WGPU %: %\n",
            level,
            from_wgpu_string_view(message),
        );
    }
}

#import "Basic";
WGPU :: #import "Jai_WGPU";
Window :: #import,file "../window.jai";
