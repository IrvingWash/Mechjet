Renderer_Handle :: #type *void;

init_renderer :: (window: Window.Window_Handle) -> ok: bool, Renderer_Handle {
    renderer := New(Renderer);

    renderer.window = window;

    init_wgpu(renderer.window);

    return true, renderer;
}

deinit_renderer :: (handle: Renderer_Handle) {
    renderer := cast(*Renderer, handle);

    free(renderer);
    // @Incomplete
}



#scope_file

Renderer :: struct {
    window: Window.Window_Handle;
}

from_wgpu_string_view :: (text: WGPU.StringView) -> string {
    return {
        data  = text.data,
        count = xx text.length,
    };
}

to_wgpu_string_view :: (text: string) -> WGPU.StringView {
    return {
        data   = text.data,
        length = xx text.count
    };
}

init_wgpu :: (window: Window.Window_Handle) -> ok: bool {
    WGPU.SetLogCallback(wgpu_log_handler, null);

    instance := WGPU.CreateInstance(null);
    if instance == null {
        log_error("Failed to create WGPU Instance");
        return false;
    }
    defer WGPU.InstanceRelease(instance);

    ok, surface := create_wgpu_surface(window, instance);
    if !ok {
        return false;
    }

    ok=, adapter := request_wgpu_adapter(instance, surface);
    if !ok {
        return false;
    }
    defer WGPU.AdapterRelease(adapter);

    surface_capabilities: WGPU.SurfaceCapabilities;
    status := WGPU.SurfaceGetCapabilities(surface, adapter, *surface_capabilities);
    if status != .Success {
        log_error("Failed to get WGPU Surface Capabilities");
        return false;
    }

    // @Incomplete get the device

    return true;
}

request_wgpu_adapter :: (instance: WGPU.Instance, surface: WGPU.Surface) -> ok: bool, WGPU.Adapter {
    options: WGPU.RequestAdapterOptions = {
        featureLevel         = .Core,
        powerPreference      = .HighPerformance,
        forceFallbackAdapter = xx false,
        compatibleSurface    = surface,
        backendType          = .Undefined, // @Robustness maybe set to platform-preffered?
    };

    User_Data :: struct {
        ok:      bool;
        adapter: WGPU.Adapter;
    }

    user_data: User_Data;

    callback: WGPU.RequestAdapterCallback : (
        status: WGPU.RequestAdapterStatus,
        adapter: WGPU.Adapter,
        message: WGPU.StringView,
        userdata1: *void,
        userdata2: *void,
    ) #c_call {
        user_data := cast(*User_Data, userdata1);

        if status != .Success {
            push_context {
                log_error("Failed to request WGPU Adapter: %: %", status, from_wgpu_string_view(message));
            }
            return;
        }

        user_data.ok      = true;
        user_data.adapter = adapter;

    }

    callback_info: WGPU.RequestAdapterCallbackInfo = {
        callback  = callback,
        userdata1 = *user_data,
    };

    WGPU.InstanceRequestAdapter(instance, *options, callback_info);

    if !user_data.ok {
        log_error("Failed to get WGPU Adapter");
        return false, user_data.adapter;
    }

    return true, user_data.adapter;
}

create_wgpu_surface :: (window: Window.Window_Handle, instance: WGPU.Instance) -> ok: bool, WGPU.Surface {
    info := Window.get_platform_specific_info(window);

    descriptor: WGPU.SurfaceDescriptor = {
        label = to_wgpu_string_view("Main surface"),
    };

    #if OS == {
        case .LINUX;
            xlib_surface_source: WGPU.SurfaceSourceXlibWindow = {
                display = info.x11.display,
                window  = info.x11.window,
                chain   = WGPU.ChainedStruct.{
                    sType = .SurfaceSourceXlibWindow,
                },
            };

            descriptor.nextInChain = *xlib_surface_source.chain;
        case;
            assert(false, "'%' is not supported!");
    }

    surface := WGPU.InstanceCreateSurface(instance, *descriptor);
    if surface == null {
        log_error("Failed to create WGPU Surface");
        return false, surface;
    }

    return true, surface;
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
