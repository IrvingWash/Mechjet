Scene :: struct {
    name:   string;

    // Flat array of all the nodes
    nodes:     [..]Node;
    // Flat array of all the meshes
    meshes:    [..]Mesh;
    // Flat array of all the materials
    materials: [..]Material;
}

Node :: struct {
    name: string;

    // Index to the parent-node of this node in `Scene.nodes`
    parent_index:     s32      = ABSENT;
    // Indices to the child-nodes of this node in `Scene.nodes`
    children_indices: [..]s32;

    // The index of this nodes first mesh in `Scene.meshes`
    first_mesh_index: s32 = ABSENT;
    // The amount of meshes this node holds.
    // `Scene.meshes` contains all the meshes contigiously, so you can cart with `Scene.meshes[first_mesh_index]` and increment until `mesh_count`
    mesh_count:       s32;

    // Row-major
    local_transform: Matrix4 = Matrix4_Identity;
}

Mesh :: struct {
    name: string;

    vertices: [..]Vertex;
    // Only u32, sorry!
    // If count is 0 - use a non-indexed draw call
    indices:  [..]u32;
    mode:     Mode = .TRIANGLES;

    min_position: Vector3;
    max_position: Vector3;

    // Index to the matireal in `Scene.materials`
    material_index: s32 = ABSENT;

    INDEX_TYPE :: u32;

    Mode :: GLTF_Mesh.Primitive.Mode;
}

Vertex :: struct {
    position: Vector3;
    normal:   Vector3 = { 0, 0, 1 };
    uv:       Vector2;

    POSITION_OFFSET :: 0;
    NORMAL_OFFSET   :: size_of(Vector3);
    UV_OFFSET       :: size_of(Vector3) * 2;
}

Material :: struct {
    name: string;

    double_sided: bool;
    alpha_mode:   Alpha_Mode = .OPAQUE;
    alpha_cutoff: float      = 0.5;

    pbr_metallic_roughness: PBR_Metallic_Roughness;
    normal_texture:         Normal_Texture;
    occlusion_texture:      Occlusion_Texture;
    emissive_texture:       Emissive_Texture;

    Alpha_Mode :: #type GLTF_Material.Alpha_Mode;

    PBR_Metallic_Roughness :: struct {
        base_color_factor: Vector4 = { 1, 1, 1, 1 };
        metallic_factor:   float   = 1;
        roughness_factor:  float   = 1;

        base_color_texture: Texture;
        metallic_roughness_texture: Texture;
    }

    Normal_Texture :: struct {
        scale:   float    = 1;
        texture: Texture;
    }

    Occlusion_Texture :: struct {
        strength: float    = 1;
        texture:  Texture;
    }

    Emissive_Texture :: struct {
        factor:  Vector3;
        texture: Texture;
    }

    Texture :: struct {
        // Only one of these will be populated
        // @Todo make this a union when we have full supported for unions in the compiler
        image_path: string;
        image_data: string;

        mag_filter: Mag_Filter = .UNKNOWN;
        min_filter: Min_Filter = .UNKNOWN;
        wrap_s:     Wrap_Mode  = .REPEAT;
        wrap_t:     Wrap_Mode  = .REPEAT;

        Mag_Filter :: #type GLTF_Sampler.Mag_Filter;
        Min_Filter :: #type GLTF_Sampler.Min_Filter;
        Wrap_Mode  :: #type GLTF_Sampler.Wrap_Mode;
    }
}
