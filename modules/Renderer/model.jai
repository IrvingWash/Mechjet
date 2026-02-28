#scope_module

Mesh :: struct { // @no_merge
    vertex_buffer: WGPU.Buffer;
    index_buffer:  WGPU.Buffer;
    index_count:   u32;
}

Vertex :: struct { // @no_merge
    position: Vector3;
    normal:   Vector3;
    uv:       Vector2;
}



#scope_file

WGPU :: #import "WGPU";
