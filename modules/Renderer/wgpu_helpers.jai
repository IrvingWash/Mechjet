#scope_module

WGPU_Toolbox :: struct {
    surface:               WGPU.Surface;
    surface_capabilities:  WGPU.SurfaceCapabilities;
    device:                WGPU.Device;
    queue:                 WGPU.Queue;
    surface_configuration: WGPU.SurfaceConfiguration;
}

init_wgpu :: (window: Window.Window_Handle) -> ok: bool, WGPU_Toolbox {
    toolbox: WGPU_Toolbox;

    WGPU.SetLogCallback(wgpu_log_handler, null);

    instance := WGPU.CreateInstance(null);
    if instance == null {
        log_error("Failed to create WGPU Instance");
        return false, toolbox;
    }
    defer WGPU.InstanceRelease(instance);

    ok:, toolbox.surface = create_wgpu_surface(window, instance);
    if !ok {
        return false, toolbox;
    }

    ok=, adapter := get_wgpu_adapter(instance, toolbox.surface);
    if !ok {
        return false, toolbox;
    }
    defer WGPU.AdapterRelease(adapter);
    {
        adapter_info: WGPU.AdapterInfo;
        WGPU.AdapterGetInfo(adapter, *adapter_info);
        log("WGPU initialized with % backend", adapter_info.backendType);
    }

    status := WGPU.SurfaceGetCapabilities(toolbox.surface, adapter, *toolbox.surface_capabilities);
    if status != .Success {
        log_error("Failed to get WGPU Surface Capabilities");
        return false, toolbox;
    }

    ok, toolbox.device = get_wgpu_device(adapter);
    if !ok {
        return false, toolbox;
    }

    toolbox.surface_configuration = configure_wgpu_surface(toolbox.surface, toolbox.device, toolbox.surface_capabilities, window);

    toolbox.queue = WGPU.DeviceGetQueue(toolbox.device);

    return true, toolbox;
}

deinit_wgpu :: (toolbox: WGPU_Toolbox) {
    WGPU.SurfaceCapabilitiesFreeMembers(toolbox.surface_capabilities);

    WGPU.QueueRelease(toolbox.queue);

    WGPU.SurfaceUnconfigure(toolbox.surface);

    WGPU.DeviceRelease(toolbox.device);

    WGPU.SurfaceRelease(toolbox.surface);
}

get_wgpu_surface_texture_view :: (surface: WGPU.Surface) -> ok: bool, WGPU.TextureView, WGPU.Texture {
    surface_texture: WGPU.SurfaceTexture;
    WGPU.SurfaceGetCurrentTexture(surface, *surface_texture);

    if surface_texture.status > .SuccessSuboptimal {
        // @Todo maybe pass up the actual status
        return false, null, null;
    }

    descriptor: WGPU.TextureViewDescriptor = {
        format          = WGPU.TextureGetFormat(surface_texture.texture),
        dimension       = ._2D,
        mipLevelCount   = 1,
        arrayLayerCount = 1,
        aspect          = .All,
        usage           = WGPU.WGPUTextureUsage_RenderAttachment,
    };

    return true, WGPU.TextureCreateView(surface_texture.texture, *descriptor), surface_texture.texture;
}

create_wgpu_shader_module :: (device: WGPU.Device, path: string) -> ok: bool, WGPU.ShaderModule {
    code, ok := read_entire_file(path,, temp);
    if !ok {
        log_error("Failed to read shader file at '%'", path);
        return false, null;
    }

    source: WGPU.ShaderSourceWGSL = {
        chain = { sType = .ShaderSourceWGSL },
        code = WGPU.to_string_view(code),
    };

    descriptor: WGPU.ShaderModuleDescriptor = {
        nextInChain = *source.chain,
    };

    return true, WGPU.DeviceCreateShaderModule(device, *descriptor);
}



#scope_file

configure_wgpu_surface :: (
    surface: WGPU.Surface,
    device: WGPU.Device,
    capabilities: WGPU.SurfaceCapabilities,
    window: Window.Window_Handle,
) -> WGPU.SurfaceConfiguration {
    width, height := Window.get_framebuffer_size(window);

    if capabilities.formats[0] != .BGRA8UnormSrgb {
        log_error("Got a % texture format for Surface, but wanted %", capabilities.formats[0], WGPU.TextureFormat.BGRA8UnormSrgb );
    }

    config: WGPU.SurfaceConfiguration = {
        device      = device,
        format      = capabilities.formats[0],
        usage       = WGPU.WGPUTextureUsage_RenderAttachment,
        width       = width,
        height      = height,
        alphaMode   = .Opaque,
        presentMode = .Fifo,
    };

    WGPU.SurfaceConfigure(surface, *config);

    return config;
}

get_wgpu_device :: (adapter: WGPU.Adapter) -> ok: bool, WGPU.Device {
    on_device_lost: WGPU.DeviceLostCallback : (
        device: *WGPU.Device,
        reason: WGPU.DeviceLostReason,
        message: WGPU.StringView,
        user_data1: *void,
        user_data2: *void,
    ) #c_call {
        push_context {
            log_error("WGPU Device is lost: %: %", reason, WGPU.from_string_view(message));
        }
    }

    on_uncaptured_error: WGPU.UncapturedErrorCallback : (
        device: *WGPU.Device,
        type: WGPU.ErrorType,
        message: WGPU.StringView,
        user_data1: *void,
        user_data2: *void,
    ) #c_call {
        push_context {
            log_error("WGPU uncaptured error: %: %", type, WGPU.from_string_view(message));
        }
    }

    descriptor: WGPU.DeviceDescriptor = {
        label        = WGPU.to_string_view("Main Device"),
        defaultQueue = WGPU.QueueDescriptor.{
            label = WGPU.to_string_view("Main Queue"),
        },
        deviceLostCallbackInfo = WGPU.DeviceLostCallbackInfo.{
            callback = on_device_lost,
        },
        uncapturedErrorCallbackInfo = WGPU.UncapturedErrorCallbackInfo.{
            callback = on_uncaptured_error,
        }
    };

    On_Device_User_Data :: struct {
        ok:     bool;
        device: WGPU.Device;
    }

    on_device_user_data: On_Device_User_Data;

    on_device: WGPU.RequestDeviceCallback : (
        status: WGPU.RequestDeviceStatus,
        device: WGPU.Device,
        message: WGPU.StringView,
        user_data1: *void,
        user_data2: *void,
    ) #c_call {
        user_data := cast(*On_Device_User_Data, user_data1);

        if status != .Success {
            push_context {
                log_error("Failed to request WGPU Device: %: %", status, WGPU.from_string_view(message));
            }
            return;
        }

        user_data.ok     = true;
        user_data.device = device;
    }

    request_device_callback_info: WGPU.RequestDeviceCallbackInfo = {
        callback  = on_device,
        userdata1 = *on_device_user_data,
    };

    WGPU.AdapterRequestDevice(adapter, *descriptor, request_device_callback_info);

    if !on_device_user_data.ok {
        log_error("Failed to get WGPU Device");
        return false, null;
    }

    return true, on_device_user_data.device;
}

get_wgpu_adapter :: (instance: WGPU.Instance, surface: WGPU.Surface) -> ok: bool, WGPU.Adapter {
    options: WGPU.RequestAdapterOptions = {
        featureLevel         = .Core,
        powerPreference      = .HighPerformance,
        forceFallbackAdapter = xx false,
        compatibleSurface    = surface,
        backendType          = .Undefined,
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
        user_data1: *void,
        user_data2: *void,
    ) #c_call {
        user_data := cast(*User_Data, user_data1);

        if status != .Success {
            push_context {
                log_error("Failed to request WGPU Adapter: %: %", status, WGPU.from_string_view(message));
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
        label = WGPU.to_string_view("Main Surface"),
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
        case .MACOS;
            metal_surface_source: WGPU.SurfaceSourceMetalLayer = {
                layer = info.cocoa.metal_layer,
                chain = WGPU.ChainedStruct.{
                    sType = .SurfaceSourceMetalLayer,
                },
            };

            descriptor.nextInChain = *metal_surface_source.chain;
        case .WINDOWS;
            hwnd_surface_source: WGPU.SurfaceSourceWindowsHWND = {
                hwnd      = info.win32.hwnd,
                hinstance = info.win32.hinstance,
                chain = WGPU.ChainedStruct.{
                    sType = .SurfaceSourceWindowsHWND,
                },
            };

            descriptor.nextInChain = *hwnd_surface_source.chain;
        case;
            assert(false, "'%' is not supported!", OS);
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
            WGPU.from_string_view(message),
        );
    }
}

#import "File";
WGPU   :: #import "WGPU";
Window :: #import "Window";
