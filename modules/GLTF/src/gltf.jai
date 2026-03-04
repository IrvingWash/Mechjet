#scope_module

GLTF :: struct {
    asset: GLTF_Asset;

    _scene: s32 = ABSENT; @JsonName(scene)

    accessors:    [..]GLTF_Accessor;
    buffers:      [..]GLTF_Buffer;
    buffer_views: [..]GLTF_Buffer_View; @JsonName(bufferViews)
    images:       [..]GLTF_Image;
    materials:    [..]GLTF_Material;
    meshes:       [..]GLTF_Mesh;
    nodes:        [..]GLTF_Node;
    samplers:     [..]GLTF_Sampler;
    scenes:       [..]GLTF_Scene;
    textures:     [..]GLTF_Texture;

    // The binary buffer from glb is stored here.
    // There's, of course, no such a field in the spec, but this is the simplest way to pass the data around.
    loaded_buffer_from_glb: string; @JsonIgnore
}

GLTF_Asset :: struct {
    version:     string;
    generator:   string;
    copyright:   string;
    min_version: string; @JsonName(minVersion)
}

GLTF_Accessor :: struct {
    _buffer_view:    s32            = ABSENT;   @JsonName(bufferView)
     byte_offset:    s32;                       @JsonName(byteOffset)
     component_type: Component_Type = .UNKNOWN; @JsonName(componentType)
     normalized:     bool;
     count:          s32;
     type:           Accessor_Type  = .UNKNOWN;
     max:            [..]float;
     min:            [..]float;
     name:           string;
     sparse:         Sparse_Incomplete;

     Sparse_Incomplete :: struct {
        // Yes, this is a required field. We are setting it to ABSENT to see if the object itself is present in the GLTF file
        _count: s32 = ABSENT; @JsonName(count)
     }

    Component_Type :: enum s32 #specified {
        UNKNOWN        :: 0;
        BYTE           :: 5120;
        UNSIGNED_BYTE  :: 5121;
        SHORT          :: 5122;
        UNSIGNED_SHORT :: 5123;
        UNSIGNED_INT   :: 5125;
        FLOAT          :: 5126;
    }

    Accessor_Type :: enum {
        UNKNOWN;
        SCALAR;
        VEC2;
        VEC3;
        VEC4;
        MAT2;
        MAT3;
        MAT4;
    }
}

GLTF_Buffer :: struct {
    _uri: string;      @JsonName(uri)
     byte_length: s32; @JsonName(byteLength)
     name: string;
}

GLTF_Buffer_View :: struct {
     buffer:      s32;
     byte_offset: s32;               @JsonName(byteOffset)
     byte_length: s32;               @JsonName(byteLength)
    _byte_stride: s32    = ABSENT;   @JsonName(byteStride)
     target:      Target = .UNKNOWN; @JsonName(target)
     name: string;

    Target :: enum s32 #specified {
        UNKNOWN              :: 0;
        ARRAY_BUFFER         :: 34962;
        ELEMENT_ARRAY_BUFFER :: 34963;
    }
}

GLTF_Image :: struct {
    _uri:         string;         @JsonName(uri)
    _buffer_view: s32 =   ABSENT; @JsonName(bufferView)
     name:        string;
     mime_type:   string;         @JsonName(mimeType)
}

GLTF_Material :: struct {
    pbr_metallic_roughness: PBR_Metallic_Roughness;            @JsonName(pbrMetallicRoughness)
    normal_texture:         Normal_Texture_Info;               @JsonName(normalTexture)
    occlusion_texture:      Occlusion_Texture_Info;            @JsonName(occlusionTexture)
    emissive_texture:       Texture_Info;                      @JsonName(emissiveTexture)
    emissive_factor:        [3]float;                          @JsonName(emissiveFactor)
    alpha_mode:             Alpha_Mode              = .OPAQUE; @JsonName(alphaMode)
    alpha_cutoff:           float                   = 0.5;     @JsonName(alphaCutoff)
    double_sided:           bool;                              @JsonName(doubleSided)
    name:                   string;

    PBR_Metallic_Roughness :: struct {
        base_color_factor:          [4]float      = float.[1, 1, 1, 1]; @JsonName(baseColorFactor)
        base_color_texture:         Texture_Info;                       @JsonName(baseColorTexture)
        metallic_factor:            float         = 1;                  @JsonName(metallicFactor)
        roughness_factor:           float         = 1;                  @JsonName(roughnessFactor)
        metallic_roughness_texture: Texture_Info;                       @JsonName(metallicRoughnessTexture)
    }

    Normal_Texture_Info :: struct {
        using texture: Texture_Info;

        scale: float = 1;
    }

    Occlusion_Texture_Info :: struct {
        using texture: Texture_Info;

        strength: float = 1;
    }

    Alpha_Mode :: enum {
        UNKNOWN;
        OPAQUE;
        MASK;
        BLEND;
    }

    Texture_Info :: struct {
        _index:     s32 = ABSENT; @JsonName(index)
         tex_coord: s32;          @JsonName(texCoord)
    }
}

GLTF_Mesh :: struct {
    primitives: [..]Primitive;
    name:       string;

    Primitive :: struct {
         attributes: Attributes;
        _indices:    s32         = ABSENT;     @JsonName(indices)
        _material:   s32         = ABSENT;     @JsonName(material)
         mode:       Mode        = .TRIANGLES;

        Attributes :: struct {
            _position:   s32 = ABSENT; @JsonName(POSITION)
            _normal:     s32 = ABSENT; @JsonName(NORMAL)
            _texcoord_0: s32 = ABSENT; @JsonName(TEXCOORD_0)
        }

        Mode :: enum s32 #specified {
            POINTS         :: 0;
            LINES          :: 1;
            LINE_LOOP      :: 2;
            LINE_STRIP     :: 3;
            TRIANGLES      :: 4;
            TRIANGLE_STRIP :: 5;
            TRIANGLE_FAN   :: 6;
        }
    }
}

GLTF_Node :: struct {
     children:    [..]s32;
     // GLTF provides column-major matrix, but Jai has row-major.
     // But it doesn't matter here because Matrix4_Identity == transpose(Matrix4_Identity).
     matrix:      [16]float = #run Matrix4_Identity.floats;
    _mesh:        s32       = ABSENT;                       @JsonName(mesh)
     rotation:    [4]float  = float.[0, 0, 0, 1];
     scale:       [3]float  = float.[1, 1, 1];
     translation: [3]float;
     name:        string;
}

GLTF_Sampler :: struct {
    mag_filter: Mag_Filter = .UNKNOWN; @JsonName(magFilter)
    min_filter: Min_Filter = .UNKNOWN; @JsonName(minFilter)
    wrap_s:     Wrap_Mode  = .REPEAT;  @JsonName(wrapS)
    wrap_t:     Wrap_Mode  = .REPEAT;  @JsonName(wrapT)
    name:       string;

    Mag_Filter :: enum s32 #specified {
        UNKNOWN :: 0;
        NEAREST :: 9728;
        LINEAR  :: 9729;
    }

    Min_Filter :: enum s32 #specified {
        UNKNOWN                :: 0;
        NEAREST                :: 9728;
        LINEAR                 :: 9729;
        NEAREST_MIPMAP_NEAREST :: 9984;
        LINEAR_MIPMAP_NEAREST  :: 9985;
        NEAREST_MIPMAP_LINEAR  :: 9986;
        LINEAR_MIPMAP_LINEAR   :: 9987;
    }

    Wrap_Mode :: enum s32 #specified {
        CLAMP_TO_EDGE   :: 33071;
        MIRRORED_REPEAT :: 33648;
        REPEAT          :: 10497;
    }
}

GLTF_Scene :: struct {
    nodes: [..]s32;
    name:  string;
}

GLTF_Texture :: struct {
    _sampler: s32     = ABSENT; @JsonName(sampler)
    _source:  s32     = ABSENT; @JsonName(source)
     name:    string;
}

GLB_Header :: struct {
    magic: u32;
    version: u32;
    length: u32;
}

GLB_Chunk_Info :: struct {
    length: u32;
    type:   Chunk_Type;

    Chunk_Type :: enum u32 #specified {
        JSON :: 0x4E4F534A;
        BIN  :: 0x004E4942;
    }
}
