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

    POSITION_OFFSET :: 0;
    NORMAL_OFFSET   :: size_of(Vector3);
    UV_OFFSET       :: size_of(Vector3) * 2;
}



#scope_file

WGPU :: #import "WGPU";
