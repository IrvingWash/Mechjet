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
    vertex_buffer: WGPU.Buffer;
    index_buffer:  WGPU.Buffer;
    index_count:   u32;

    material: Material;
}

Material :: struct {} // @Todo

Vertex :: struct {
    position: Vector3;
    normal:   Vector3;
    uv:       Vector2;

    POSITION_OFFSET :: 0;
    NORMAL_OFFSET   :: size_of(Vector3);
    UV_OFFSET       :: size_of(Vector3) * 2;
}

// @Todo we are using GLTF here, but preferably the convertation should be done in the asset storage
// @Todo optimize copying
create_model :: (handle: Renderer_Handle, gltf_scene: GLTF.Scene) -> Model { // @no_merge
    renderer := cast(*Renderer, handle);

    using,only(device, queue) renderer.wgpu_toolbox;

    model: Model;
    array_resize(*model.nodes, gltf_scene.nodes.count);
    array_resize(*model.meshes, gltf_scene.meshes.count);

    for node, i: gltf_scene.nodes {
        model.nodes[i] = {
            parent_index = node.parent_index,
            first_mesh_index = node.first_mesh_index,
            mesh_count = cast(u32, node.mesh_count),
            local_transform = node.local_transform,
        };

        array_resize(*model.nodes[i].children_indices, node.children_indices.count);
        for child_index: node.children_indices {
            model.nodes[i].children_indices[it_index] = cast(u32, child_index);
        }
    }

    for mesh_data: gltf_scene.meshes {
        model.meshes[it_index] = create_mesh(mesh_data, device, queue);
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

create_mesh :: (mesh_data: GLTF.Mesh, device: WGPU.Device, queue: WGPU.Queue) -> Mesh {
    mesh: Mesh;

    // mesh.material = @Todo!

    mesh.index_count = cast(u32, mesh_data.indices.count);

    index_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Index,
        size  = WGPU.to_copy_buffer_alignment(cast(u32, mesh_data.indices.count) * size_of(u32)),
        mappedAtCreation = xx false, // @Todo maybe true
    };
    mesh.index_buffer = WGPU.DeviceCreateBuffer(device, *index_buffer_descriptor);
    WGPU.QueueWriteBuffer(queue, mesh.index_buffer, 0, mesh_data.indices.data, WGPU.BufferGetSize(mesh.index_buffer));

    vertex_buffer_descriptor: WGPU.BufferDescriptor = {
        usage = WGPU.WGPUBufferUsage_CopyDst | WGPU.WGPUBufferUsage_Vertex,
        size  = WGPU.to_copy_buffer_alignment(cast(u32, mesh_data.vertices.count) * size_of(Vertex)),
        mappedAtCreation = xx false, // @Todo maybe true
    };
    mesh.vertex_buffer = WGPU.DeviceCreateBuffer(device, *vertex_buffer_descriptor);
    WGPU.QueueWriteBuffer(queue, mesh.vertex_buffer, 0, mesh_data.vertices.data, WGPU.BufferGetSize(mesh.vertex_buffer));

    return mesh;
}

WGPU :: #import "WGPU";
GLTF :: #import "GLTF"; // @no_merge
