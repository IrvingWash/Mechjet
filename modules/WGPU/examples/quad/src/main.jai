// Jai version of https://eliemichel.github.io/LearnWebGPU

#import "Basic";
#import "Math";
#import "SDL";
#import "File";
#import "String";
WGPU :: #import,file "../../../module.jai";

WINDOW_WIDTH  :: 640;
WINDOW_HEIGHT :: 480;

should_quit: bool;

VERTEX_SHADER_ENTRY_POINT   :: "vs_main";
FRAGMENT_SHADER_ENTRY_POINT :: "fs_main";

SHADER_SOURCE :: #run read_entire_file(path_join(#filepath, "shader.wgsl"));

VERTEX_DATA :: float.[
    -0.5, -0.5,   1, 0, 0,
     0.5, -0.5,   0, 1, 0,
     0.5,  0.5,   0, 0, 1,
    -0.5,  0.5,   1, 1, 0,
];

VERTEX_INDICES :: u16.[
    0, 1, 2,
    0, 2, 3,
];

main :: () {
    WGPU.SetLogCallback(wgpu_log_handler, null);

    window := create_window("Triangle", WINDOW_WIDTH, WINDOW_HEIGHT);
    defer destroy_window(window);

    instance := WGPU.CreateInstance(null);
    assert(instance != null, "Failed to create WGPU Instance");

    surface := create_wgpu_surface(window, instance);
    defer WGPU.SurfaceRelease(surface);

    adapter := request_wgpu_adapter(instance, surface);
    WGPU.InstanceRelease(instance);

    surface_capabilities: WGPU.SurfaceCapabilities;
    WGPU.SurfaceGetCapabilities(surface, adapter, *surface_capabilities);
    defer WGPU.SurfaceCapabilitiesFreeMembers(surface_capabilities);

    surface_format := surface_capabilities.formats[0];

    device := request_wgpu_device(adapter);
    defer WGPU.DeviceRelease(device);
    WGPU.AdapterRelease(adapter);

    configure_wgpu_surface(surface, device, WINDOW_WIDTH, WINDOW_HEIGHT, surface_format);
    defer WGPU.SurfaceUnconfigure(surface);

    queue := WGPU.DeviceGetQueue(device);
    assert(queue != null, "Failed to get WGPU Queue");
    defer WGPU.QueueRelease(queue);

    // Vertex buffer
    vertex_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Vertex,
        size  = VERTEX_DATA.count * size_of(float),
    };
    vertex_buffer := WGPU.DeviceCreateBuffer(device, *vertex_buffer_descriptor);
    defer WGPU.BufferRelease(vertex_buffer);

    WGPU.QueueWriteBuffer(queue, vertex_buffer, 0, VERTEX_DATA.data, vertex_buffer_descriptor.size);

    // Index buffer
    index_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Index,
        size  = (VERTEX_INDICES.count * size_of(u16) + 3) & ~3, // The size of the index buffer must be a multiple of 4
    };
    index_buffer := WGPU.DeviceCreateBuffer(device, *index_buffer_descriptor);
    defer WGPU.BufferRelease(index_buffer);

    WGPU.QueueWriteBuffer(queue, index_buffer, 0, VERTEX_INDICES.data, index_buffer_descriptor.size);

    // Uniform buffer
    uniform_buffer_descriptor: WGPU.BufferDescriptor = {
        size  = 4 * size_of(float),
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Uniform,
    };
    uniform_buffer := WGPU.DeviceCreateBuffer(device, *uniform_buffer_descriptor);
    defer WGPU.BufferRelease(uniform_buffer);

    time: float = xx seconds_since_init();
    WGPU.QueueWriteBuffer(queue, uniform_buffer, 0, *time, size_of(float));

    // Bind group
    bind_group_layout_entry: WGPU.BindGroupLayoutEntry = {
        binding    = 0,
        visibility = WGPU.WGPUShaderStage_Vertex,
        buffer     = {
            type = .Uniform,
            minBindingSize = 4 * size_of(float),
        },
    };

    bind_group_layout_descriptor: WGPU.BindGroupLayoutDescriptor = {
        entryCount = 1,
        entries    = *bind_group_layout_entry,
    };

    bind_group_layout := WGPU.DeviceCreateBindGroupLayout(
        device,
        *bind_group_layout_descriptor,
    );
    defer WGPU.BindGroupLayoutRelease(bind_group_layout);
    bind_group_entry: WGPU.BindGroupEntry = {
        binding = 0,
        buffer = uniform_buffer,
        offset = 0,
        size = WGPU.BufferGetSize(uniform_buffer),
    };
    bind_group_descriptor: WGPU.BindGroupDescriptor = {
        layout     = bind_group_layout,
        entryCount = 1,
        entries   = *bind_group_entry,
    };
    bind_group := WGPU.DeviceCreateBindGroup(device, *bind_group_descriptor);
    defer WGPU.BindGroupRelease(bind_group);

    // Render pipeline
    render_pipeline := create_wgpu_render_pipeline(device, surface_format, bind_group_layout);
    defer WGPU.RenderPipelineRelease(render_pipeline);

    while !should_quit {
        process_events();

        time = xx seconds_since_init();
        WGPU.QueueWriteBuffer(queue, uniform_buffer, 0, *time, size_of(float));

        target_view, surface_texture := get_wgpu_get_target_texture_view(surface);
        defer WGPU.TextureViewRelease(target_view);

        command_encoder := WGPU.DeviceCreateCommandEncoder(device, null);

        render_pass_color_attachment: WGPU.RenderPassColorAttachment = {
            view       = target_view,
            loadOp     = .Clear,
            storeOp    = .Store,
            clearValue = { 0, 0, 1, 1 },
            depthSlice = WGPU.DEPTH_SLICE_UNDEFINED,
        };

        render_pass_descriptor: WGPU.RenderPassDescriptor = {
            colorAttachmentCount = 1,
            colorAttachments     = *render_pass_color_attachment,
        };

        render_pass := WGPU.CommandEncoderBeginRenderPass(command_encoder, *render_pass_descriptor);

        WGPU.RenderPassEncoderSetPipeline(render_pass, render_pipeline);

        WGPU.RenderPassEncoderSetVertexBuffer(render_pass, 0, vertex_buffer, 0, WGPU.BufferGetSize(vertex_buffer));
        WGPU.RenderPassEncoderSetIndexBuffer(render_pass, index_buffer, .Uint16, 0, WGPU.BufferGetSize(index_buffer));

        WGPU.RenderPassEncoderSetBindGroup(render_pass, 0, bind_group, 0, null);

        WGPU.RenderPassEncoderDrawIndexed(render_pass, VERTEX_INDICES.count, 1, 0, 0, 0);

        WGPU.RenderPassEncoderEnd(render_pass);
        WGPU.RenderPassEncoderRelease(render_pass);

        command_buffer := WGPU.CommandEncoderFinish(command_encoder, null);

        WGPU.CommandEncoderRelease(command_encoder);

        WGPU.QueueSubmit(queue, 1, *command_buffer);

        WGPU.CommandBufferRelease(command_buffer);

        WGPU.SurfacePresent(surface);

        WGPU.TextureRelease(surface_texture.texture);

        WGPU.DevicePoll(device, 0, null); // @Todo: Do we really need this?
    }
}

create_wgpu_render_pipeline :: (
    device: WGPU.Device,
    surface_format: WGPU.TextureFormat,
    bind_group_layout: WGPU.BindGroupLayout,
) -> WGPU.RenderPipeline {
    pipeline_layout_descriptor: WGPU.PipelineLayoutDescriptor = {
        bindGroupLayoutCount = 1,
        bindGroupLayouts = *bind_group_layout,
    };

    // @TODO: Not released
    pipeline_layout := WGPU.DeviceCreatePipelineLayout(
        device,
        *pipeline_layout_descriptor,
    );

    // Shader
    shader_source_wgsl: WGPU.ShaderSourceWGSL = {
        chain = {
            sType = .ShaderSourceWGSL,
        },
        code = WGPU.StringView.{
            data   = SHADER_SOURCE.data,
            length = xx SHADER_SOURCE.count,
        }
    };

    shader_module_descriptor: WGPU.ShaderModuleDescriptor = {
        nextInChain = *shader_source_wgsl.chain,
    };

    shader_module := WGPU.DeviceCreateShaderModule(device, *shader_module_descriptor);
    defer WGPU.ShaderModuleRelease(shader_module);

    // Vertex state
    attributes := WGPU.VertexAttribute.[
        { // Position
            shaderLocation = 0,
            offset         = 0,
            format         = .Float32x2,
        },
        { // Color
            shaderLocation = 1,
            offset         = size_of(Vector2),
            format         = .Float32x3,
        },
    ];
    vertex_buffer_layout: WGPU.VertexBufferLayout = {
        attributeCount = attributes.count,
        attributes     = attributes.data,
        stepMode       = .Vertex,
        arrayStride    = size_of(Vector2) + size_of(Vector3),
    };
    vertex_state: WGPU.VertexState = {
        module = shader_module,
        entryPoint = WGPU.StringView.{
            data   = VERTEX_SHADER_ENTRY_POINT.data,
            length = xx VERTEX_SHADER_ENTRY_POINT.count,
        },
        bufferCount = 1,
        buffers     = *vertex_buffer_layout,
    };

    // Primitive state
    primitive_state: WGPU.PrimitiveState = {
        topology  = .TriangleList,
        frontFace = .CCW,
        cullMode  = .None,
    };

    // Multisample state
    multisample_state: WGPU.MultisampleState = {
        count = 1,
        mask = ~cast(u32, 0),
    };

    // Fragment state
    blend_state: WGPU.BlendState = {
        color = {
            operation =  .Add,
            srcFactor = .SrcAlpha,
            dstFactor = .OneMinusSrcAlpha,
        },
        alpha = {
            operation = .Add,
            srcFactor = .Zero,
            dstFactor = .One,
        },
    };

    color_target_state: WGPU.ColorTargetState = {
        format    = surface_format,
        blend     = *blend_state,
        writeMask = WGPU.WGPUColorWriteMask_All,
    };

    fragment_state: WGPU.FragmentState = {
        module = shader_module,
        entryPoint = WGPU.StringView.{
            data   = FRAGMENT_SHADER_ENTRY_POINT.data,
            length = xx FRAGMENT_SHADER_ENTRY_POINT.count,
        },
        targetCount = 1,
        targets      = *color_target_state,
    };

    descriptor: WGPU.RenderPipelineDescriptor = {
        layout      = pipeline_layout,
        vertex      = vertex_state,
        primitive   = primitive_state,
        multisample = multisample_state,
        fragment    = *fragment_state,
    };

    return WGPU.DeviceCreateRenderPipeline(device, *descriptor);
}

get_wgpu_get_target_texture_view :: (surface: WGPU.Surface) -> WGPU.TextureView, WGPU.SurfaceTexture {
    surface_texture: WGPU.SurfaceTexture;
    WGPU.SurfaceGetCurrentTexture(surface, *surface_texture);

    descriptor: WGPU.TextureViewDescriptor = {
        format          = WGPU.TextureGetFormat(surface_texture.texture),
        dimension       = ._2D,
        mipLevelCount   = 1,
        arrayLayerCount = 1,
        aspect          = .All,
        usage           = WGPU.WGPUTextureUsage_RenderAttachment,
    };

    return WGPU.TextureCreateView(surface_texture.texture, *descriptor), surface_texture;
}

configure_wgpu_surface :: (surface: WGPU.Surface, device: WGPU.Device, width: u32, height: u32, surface_format: WGPU.TextureFormat) {
    configuration: WGPU.SurfaceConfiguration = {
        device      = device,
        format      = surface_format,
        usage       = WGPU.WGPUTextureUsage_RenderAttachment,
        width       = width,
        height      = height,
        alphaMode   = .Opaque,
        presentMode = .Fifo,
    };

    WGPU.SurfaceConfigure(surface, *configuration);
}

process_events :: () {
    event: SDL_Event;

    while SDL_PollEvent(*event) {
        if event.type == {
            case SDL_QUIT;
                should_quit = true;
        }
    }
}

request_wgpu_device :: (adapter: WGPU.Adapter) -> WGPU.Device {
    descriptor: WGPU.DeviceDescriptor = {
        uncapturedErrorCallbackInfo = {
            callback = (
                device: *WGPU.Device,
                type: WGPU.ErrorType,
                message: WGPU.StringView,
                userdata1: *void,
                userdata2: *void,
            ) #c_call {
                push_context {
                    print(
                        "WGPU: %: %",
                        type,
                        string.{
                            data  = message.data,
                            count = xx message.length,
                        },
                    );
                }
            },
        },
    };

    Result :: struct {
        device: WGPU.Device;
        ok:     bool;
    }

    result: Result;

    callback_info: WGPU.RequestDeviceCallbackInfo = {
        userdata1 = *result,
        callback  =  (
            status: WGPU.RequestDeviceStatus,
            device: WGPU.Device,
            message: WGPU.StringView,
            userdata1: *void,
            userdata2: *void,
        ) #c_call {
            result := cast(*Result, userdata1);

            if status == .Success {
                result.device = device;
                result.ok     = true;

                return;
            }

            push_context {
                print(
                    "Request Device Callback: %: %\n",
                    status,
                    string.{
                        data = message.data,
                        count = xx message.length,
                    },
                );
            }
        },
    };

    WGPU.AdapterRequestDevice(adapter, *descriptor, callback_info);

    assert(result.ok, "Failed to request WGPU Device");

    return result.device;
}

request_wgpu_adapter :: (instance: WGPU.Instance, surface: WGPU.Surface) -> WGPU.Adapter {
    options: WGPU.RequestAdapterOptions = {
        featureLevel      = .Core,
        powerPreference   = .Undefined,
        compatibleSurface = surface,
    };

    Result :: struct {
        adapter: WGPU.Adapter;
        ok:      bool;
    }

    result: Result;

    callback_info: WGPU.RequestAdapterCallbackInfo = {
        userdata1 = *result,
        callback = (
            status: WGPU.RequestAdapterStatus,
            adapter: WGPU.Adapter,
            message: WGPU.StringView,
            userdata1: *void,
            userdata2: *void,
        ) #c_call {
            result := cast(*Result, userdata1);

            if status == .Success {
                result.adapter = adapter;
                result.ok      = true;

                return;
            }

            push_context {
                print(
                    "Request Adapter Callback: %: %\n",
                    status,
                    string.{
                        data = message.data,
                        count = xx message.length,
                    },
                );
            }
        }
    };

    WGPU.InstanceRequestAdapter(
        instance,
        *options,
        callback_info,
    );

    assert(result.ok, "Failed to request WGPU Adapter");

    return result.adapter;
}

create_wgpu_surface :: (window: *SDL_Window, instance: WGPU.Instance) -> WGPU.Surface {
    sys_wm_info: SDL_SysWMinfo;

    // @Todo: This is weird
    #if OS == .LINUX {
        SDL_GetVersion(*sys_wm_info.version);
    }

    ok := SDL_GetWindowWMInfo(window, *sys_wm_info);
    assert(ok == .SDL_TRUE, "Failed to get window info from SDL");

    surface: WGPU.Surface;

    #if OS == {
        case .LINUX;
            if sys_wm_info.subsystem != .SDL_SYSWM_X11 {
                assert(false, "Only X11 is supported for Linux, sorry!");
            }
            surface_source: WGPU.SurfaceSourceXlibWindow = {
                display = sys_wm_info.info.x11.display,
                window  = sys_wm_info.info.x11.window,
                chain   = { sType = .SurfaceSourceXlibWindow },
            };

            surface_descriptor: WGPU.SurfaceDescriptor = {
                nextInChain = *surface_source.chain,
            };

            surface = WGPU.InstanceCreateSurface(instance, *surface_descriptor);
        case .WINDOWS;
            Windows :: #import "Windows";

            surface_source: WGPU.SurfaceSourceWindowsHWND = {
                hwnd      = sys_wm_info.info.win.window,
                hinstance = Windows.GetModuleHandleW(null),
                chain     = { sType = .SurfaceSourceWindowsHWND },
            };

            surface_descriptor: WGPU.SurfaceDescriptor = {
                nextInChain = *surface_source.chain,
            };

            surface = WGPU.InstanceCreateSurface(instance, *surface_descriptor);
        case .MACOS;
            Metal  :: #import "Metal";
            ObjC   :: #import "Objective_C";
            AppKit :: #import "Objective_C/AppKit";

            ObjC.init_objective_c();
            Metal.init_metal();
            AppKit.init_app_kit();

            ns_window := cast(*AppKit.NSWindow) sys_wm_info.info.cocoa.window;
            content_view := ns_window.contentView(ns_window);
            metal_layer := ObjC.objc_new(Metal.CAMetalLayer);
            AppKit.NSView.setWantsLayer(content_view, ObjC.YES);
            {
                set_layer_sel := ObjC.sel_registerName("setLayer:");
                func: (*void, ObjC.Selector, *void) -> void #c_call;
                func = xx ObjC.objc_msgSend;
                func(content_view, set_layer_sel, metal_layer);
            }
            surface_source: WGPU.SurfaceSourceMetalLayer = {
                chain = { sType = .SurfaceSourceMetalLayer },
                layer = metal_layer,
            };

            surface_descriptor: WGPU.SurfaceDescriptor = {
                nextInChain = *surface_source.chain,
            };

            surface = WGPU.InstanceCreateSurface(instance, *surface_descriptor);
        case;
            assert(false, "'%' is not supported", OS);
    }

    assert(surface != null, "Failed to create WGPU Surface");

    return surface;
}

create_window :: ($title: string, width: s32, height: s32) -> *SDL_Window {
    ok := SDL_Init(.SDL_INIT_VIDEO);
    assert(ok == 0, "Failed to initialize SDL: %", to_string(SDL_GetError()));

    window := SDL_CreateWindow(
        title,
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        width, height,
        0,
    );
    assert(window != null, "Failed to create SDL window");

    return window;
}

destroy_window :: (window: *SDL_Window) {
    SDL_DestroyWindow(window);
    SDL_Quit();
}

wgpu_log_handler :: (
    level: WGPU.LogLevel,
    message: WGPU.StringView,
    userdata: *void,
) #c_call {
    push_context {
        print(
            "WGPU %: %\n",
            level,
            string.{
                data = message.data,
                count = xx message.length,
            },
        );
    }
}
