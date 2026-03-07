Model :: struct {
    nodes:  [..]Node;
    meshes: [..]Mesh;
}

Node :: struct {
    parent_index:     int      = -1;
    children_indices: [..]u32;

    first_mesh_index: s32 = -1;
    mesh_count:       u32;

    local_transform: Matrix4;
}

Mesh :: struct {
    vertex_buffer:   WGPU.Buffer;
    index_buffer:    WGPU.Buffer;
    index_count:     u32;

    material: Material;
}

Material :: struct {
    base_color_texture: Texture;
    double_sided:       bool;
    params:             Params;

    Params :: struct {
        base_color_factor:  Vector4 = { 1, 1, 1, 1 };
    } @GPU
}

Vertex :: struct {
    position: Vector3;
    normal:   Vector3;
    uv:       Vector2;

    POSITION_OFFSET :: 0;
    NORMAL_OFFSET   :: size_of(Vector3);
    UV_OFFSET       :: size_of(Vector3) * 2;
} @GPU

// Intermediate representation between a format (GLTF) and the data needed by the renderer
Model_Creation_Data :: struct {
    nodes:  [..]Node;
    meshes: [..]Mesh_Data;

    Mesh_Data :: struct {
        vertices: [..]Vertex;
        indices: [..]u32;
        material: Material;
    }
}

destroy_model_creation_data :: (model_creation_data: *Model_Creation_Data) {
    // We don't destroy anything related to nodes as Model takes ownership.

    for mesh: model_creation_data.meshes {
        array_free(mesh.vertices);
        array_free(mesh.indices);
    }
    array_free(model_creation_data.meshes);

    model_creation_data.* = {};
}

create_model :: (handle: Renderer_Handle, model_creation_data: Model_Creation_Data) -> Model {
    renderer := cast(*Renderer, handle);

    using,only(device, queue) renderer.wgpu_toolbox;

    model: Model;

    model.nodes = model_creation_data.nodes;

    array_resize(*model.meshes, model_creation_data.meshes.count);
    for mesh_creation_data: model_creation_data.meshes {
        model.meshes[it_index] = create_mesh(device, queue, mesh_creation_data);
    }

    return model;
}

destroy_model :: (model: *Model) {
    for node: model.nodes {
        array_free(node.children_indices);
    }
    array_free(model.nodes);

    for mesh: model.meshes {
        WGPU.BufferRelease(mesh.vertex_buffer);
        WGPU.BufferRelease(mesh.index_buffer);
    }
    array_free(model.meshes);

    model.* = {};
}



#scope_file

create_mesh :: (device: WGPU.Device, queue: WGPU.Queue, mesh_creation_data: Model_Creation_Data.Mesh_Data) -> Mesh {
    mesh: Mesh;

    mesh.material = mesh_creation_data.material;

    { // Index buffer
        mesh.index_count = cast(u32, mesh_creation_data.indices.count);

        index_data_size := mesh.index_count * size_of(u32);

        index_buffer_descriptor: WGPU.BufferDescriptor = {
            usage            = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Index,
            size             = WGPU.to_copy_buffer_alignment(index_data_size),
            mappedAtCreation = xx false, // @Todo maybe true
        };

        mesh.index_buffer = WGPU.DeviceCreateBuffer(device, *index_buffer_descriptor);

        WGPU.QueueWriteBuffer(queue, mesh.index_buffer, 0, mesh_creation_data.indices.data, index_data_size);
    }

    { // Vertex buffer
        vertex_data_size := cast(u32, mesh_creation_data.vertices.count * size_of(Vertex));

        vertex_buffer_descriptor: WGPU.BufferDescriptor = {
            usage            = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Vertex,
            size             = WGPU.to_copy_buffer_alignment(vertex_data_size),
            mappedAtCreation = xx false, // @Todo maybe true
        };

        mesh.vertex_buffer = WGPU.DeviceCreateBuffer(device, *vertex_buffer_descriptor);

        WGPU.QueueWriteBuffer(queue, mesh.vertex_buffer, 0, mesh_creation_data.vertices.data, vertex_data_size);
    }

    return mesh;
}

WGPU :: #import "WGPU";
