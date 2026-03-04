Texture :: struct {
    texture: WGPU.Texture;
    view:    WGPU.TextureView;
    sampler: WGPU.Sampler;
    kind:    Texture_Kind;
}

Texture_Kind :: enum {
    BASE_COLOR;
}

create_base_color_texture :: (
    handle: Renderer_Handle,
    path: string,
) -> Texture {
    renderer := cast(*Renderer, handle);
    using renderer.wgpu_toolbox;

    texture: Texture;

    texture.kind = .BASE_COLOR;

    image := load_image(path);
    defer release_image(image.data);

    // Texture

    texture_descriptor := WGPU.TextureDescriptor.{
        usage     = WGPU.WGPUTextureUsage_CopyDst | WGPU.WGPUTextureUsage_TextureBinding,
        dimension       = ._2D,
        size            = WGPU.Extent3D.{
            width              = image.width,
            height             = image.height,
            depthOrArrayLayers = 1,
        },
        format          = .RGBA8UnormSrgb, // @no_merge hardcode!
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

    // Texture View

    texture_view_descriptor := WGPU.TextureViewDescriptor.{
        format          = .RGBA8UnormSrgb, // @no_merge hardcode!
        dimension       = ._2D,
        baseMipLevel    = 0,
        mipLevelCount   = 1,
        baseArrayLayer  = 0,
        arrayLayerCount = 1,
        aspect          = .All,
        usage           = WGPU.WGPUTextureUsage_None,
    };
    texture.view = WGPU.TextureCreateView(texture.texture, *texture_view_descriptor);

    // Sampler

    sampler_descriptor := WGPU.SamplerDescriptor.{
        addressModeU  = .ClampToEdge, // @Todo hardcode!
        addressModeV  = .ClampToEdge, // @Todo hardcode!
        addressModeW  = .ClampToEdge, // @Todo hardcode!
        magFilter     = .Linear, // @Todo hardcode!
        minFilter     = .Nearest, // @Todo hardcode!
        mipmapFilter  = .Nearest, // @Todo hardcode!
        lodMinClamp   = 0, // @Todo hardcode!
        lodMaxClamp   = 32, // @Todo hardcode!
        compare       = .Undefined, // @Todo hardcode!
        maxAnisotropy = 1, // @Todo hardcode!
    };

    texture.sampler = WGPU.DeviceCreateSampler(device, *sampler_descriptor);

    return texture;
}

destroy_texture :: (texture: Texture) {
    WGPU.SamplerRelease(texture.sampler);
    WGPU.TextureViewRelease(texture.view);
    WGPU.TextureRelease(texture.texture);
}



#scope_file

Image :: struct {
    width:         u32;
    height:        u32;
    channel_count: u32;
    data:          *u8;
}

load_image :: (path: string) -> Image {
    width, height, channel_count: s32;
    data := stbi_load(temp_c_string(path), *width, *height, *channel_count, 4);
    assert(data != null); // @no_merge @Todo handle more graecully!

    return Image.{
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
GLTF :: #import "GLTF";
