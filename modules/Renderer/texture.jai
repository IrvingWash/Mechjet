Texture :: struct {
    texture: WGPU.Texture;
    view:    WGPU.TextureView;
    sampler: WGPU.Sampler;
    kind:    Texture_Kind;
}

Texture_Kind :: enum {
    BASE_COLOR;
    DEPTH;
}

Address_Mode :: WGPU.AddressMode;
Filter_Mode  :: WGPU.FilterMode;

create_base_color_texture :: (
    handle: Renderer_Handle,
    path: string,
    wrap_s: Address_Mode,
    wrap_t: Address_Mode,
    mag_filter: Filter_Mode,
    min_filter: Filter_Mode,
) -> ok: bool, Texture {
    renderer := cast(*Renderer, handle);
    using renderer.wgpu_toolbox;

    texture: Texture;

    texture.kind = .BASE_COLOR;

    { // Texture
        ok, image := load_image(path);
        if !ok {
            log_error("Failed to load image from '%'", path);
            return false, texture;
        }
        defer release_image(image.data);

        texture_descriptor := WGPU.TextureDescriptor.{
            usage     = WGPU.WGPUTextureUsage_CopyDst | WGPU.WGPUTextureUsage_TextureBinding,
            dimension       = ._2D,
            size            = WGPU.Extent3D.{
                width              = image.width,
                height             = image.height,
                depthOrArrayLayers = 1,
            },
            format          = .RGBA8UnormSrgb, // This is hardcoded but is the only reasonable format for a base color texture
            mipLevelCount   = 1,
            sampleCount     = 1,
            viewFormatCount = 0,
            viewFormats     = null,
        };

        texture.texture = WGPU.DeviceCreateTexture(device, *texture_descriptor);

        texel_copy_texture_info := WGPU.TexelCopyTextureInfo.{
            texture  = texture.texture,
            mipLevel = 0,
            origin   = WGPU.Origin3D.{ 0, 0, 0 },
            aspect   = .All,
        };

        texel_copy_buffer_layout := WGPU.TexelCopyBufferLayout.{
            offset       = 0,
            bytesPerRow  = image.channel_count * image.width,
            rowsPerImage = image.height,
        };

        WGPU.QueueWriteTexture(
            queue,
            *texel_copy_texture_info,
            image.data,
            image.channel_count * image.width * image.height,
            *texel_copy_buffer_layout,
            *texture_descriptor.size,
        );
    }

    { // Texture View
        texture_view_descriptor := WGPU.TextureViewDescriptor.{
            format          = .RGBA8UnormSrgb,
            dimension       = ._2D,
            baseMipLevel    = 0,
            mipLevelCount   = 1,
            baseArrayLayer  = 0,
            arrayLayerCount = 1,
            aspect          = .All,
            usage           = WGPU.WGPUTextureUsage_None,
        };
        texture.view = WGPU.TextureCreateView(texture.texture, *texture_view_descriptor);
    }

    { // Sampler
        sampler_descriptor := WGPU.SamplerDescriptor.{
            addressModeU  = wrap_s,
            addressModeV  = wrap_t,
            addressModeW  = .Undefined,
            magFilter     = mag_filter,
            minFilter     = min_filter,
            mipmapFilter  = .Nearest,
            lodMinClamp   = 0,
            lodMaxClamp   = 32,
            compare       = .Undefined,
            maxAnisotropy = 1,
        };

        texture.sampler = WGPU.DeviceCreateSampler(device, *sampler_descriptor);
    }

    return true, texture;
}

destroy_texture :: (texture: Texture) {
    WGPU.SamplerRelease(texture.sampler);
    WGPU.TextureViewRelease(texture.view);
    WGPU.TextureRelease(texture.texture);
}



#scope_module

create_depth_texture :: (renderer: *Renderer, size: WGPU.Extent3D) -> Texture {
    using renderer.wgpu_toolbox;

    texture: Texture;

    texture.kind = .DEPTH;

    { // Texture
        descriptor: WGPU.TextureDescriptor = {
            usage           = WGPU.WGPUTextureUsage_TextureBinding
                | WGPU.WGPUTextureUsage_RenderAttachment,
            dimension       = ._2D,
            size            = size,
            format          = .Depth32Float,
            mipLevelCount   = 1,
            sampleCount     = 1,
            viewFormatCount = 0,
            viewFormats     = null,
        };

        texture.texture = WGPU.DeviceCreateTexture(device, *descriptor);
    }

    { // View
        descriptor: WGPU.TextureViewDescriptor = {
            format          = .Depth32Float,
            dimension       = ._2D,
            baseMipLevel    = 0,
            mipLevelCount   = 1,
            baseArrayLayer  = 0,
            arrayLayerCount = 1,
            aspect          = .All,
            usage           = WGPU.WGPUTextureUsage_None,
        };

        texture.view = WGPU.TextureCreateView(texture.texture, *descriptor);
    }

    { // Sampler
        descriptor: WGPU.SamplerDescriptor = {
            addressModeU  = .ClampToEdge,
            addressModeV  = .ClampToEdge,
            addressModeW  = .ClampToEdge,
            magFilter     = .Linear,
            minFilter     = .Linear,
            mipmapFilter  = .Nearest,
            lodMinClamp   = 0,
            lodMaxClamp   = 100,
            compare       = .LessEqual,
            maxAnisotropy = 1,
        };

        texture.sampler = WGPU.DeviceCreateSampler(device, *descriptor);
    }

    return texture;
}



#scope_file

Image :: struct {
    width:         u32;
    height:        u32;
    channel_count: u32;
    data:          *u8;
}

load_image :: (path: string) -> ok: bool, Image {
    width, height, channel_count: s32;
    data := stbi_load(temp_c_string(path), *width, *height, *channel_count, 4);
    if !data {
        log_error("Failed to load image data from '%'", path);
        return false, {};
    }

    return true, Image.{
        width         = cast(u32, width),
        height        = cast(u32, height),
        channel_count = cast(u32, channel_count),
        data          = data,
    };
}

release_image :: (data: *u8) {
    stbi_image_free(data);
}

#import "stb_image";
WGPU :: #import "WGPU";
