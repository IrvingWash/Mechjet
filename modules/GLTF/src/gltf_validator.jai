validate_gltf :: (gltf: GLTF, path: string) -> errors: string {
    push_allocator(temp);

    builder: String_Builder;

    validate_version(gltf, *builder, path);
    validate_buffers(gltf, *builder, path);
    validate_buffers_without_uris(gltf, *builder, path);
    validate_scenes(gltf, *builder, path);
    validate_textures_and_images(gltf, *builder, path);
    validate_meshes(gltf, *builder, path);

    return builder_to_string(*builder,, temp);
}

validate_glb_header :: (header: GLB_Header, path: string) -> error: string {
    if header.magic != GLB_MAGIC {
        return tprint(
            "Malformed .glb file at '%': magic is '%' instead of '%'\n",
            path,
            header.magic,
            GLB_MAGIC,
        );
    }

    if !array_find(SUPPORTED_GLB_VERSIONS, header.version) {
        return tprint(
            "Unsupported .glb version '%' at '%', we support only '%'\n",
            path,
            header.version,
            SUPPORTED_GLB_VERSIONS,
        );
    }

    return "";
}

validate_glb_json_chunk :: (json_chunk_info: GLB_Chunk_Info, path: string) -> error: string {
    if json_chunk_info.type != .JSON {
        return tprint(
            "Malformed .glb file at '%': first chunk should be of type json, but it's '%'\n",
            path,
            json_chunk_info.type,
        );
    }

    return "";
}

validate_glb_binary_chunk :: (binary_chunk_info: GLB_Chunk_Info, path: string) -> error: string {
    if binary_chunk_info.type != .BIN {
        return tprint(
            "Binary chunk in GLB at '%' is malformed: expected it's type to be BIN, but got '%'\n",
            path,
            binary_chunk_info.type,
        );
    }

    return "";
}



#scope_file

SUPPORTED_GLTF_VERSIONS :: string.["2.0"];
SUPPORTED_GLB_VERSIONS  :: u32.[2];
GLB_MAGIC :: 0x46546C67;

validate_version :: (gltf: GLTF, builder: *String_Builder, path: string) {
    if !array_find(SUPPORTED_GLTF_VERSIONS, gltf.asset.version) {
        print_to_builder(
            builder,
            "GLTF at '%' is version '%', but only % are supported\n",
            path,
            gltf.asset.version,
            SUPPORTED_GLTF_VERSIONS,
        );
    }
}

validate_scenes :: (gltf: GLTF, builder: *String_Builder, path: string) {
    // @AntiSpec
    // There should be a scene
    if gltf._scene == ABSENT {
        print_to_builder(
            builder,
            "GLTF at '%' doesn't have a default scene\n",
            path,
        );
    }

    // @AntiSpec
    // We support only one scene
    if gltf.scenes.count != 1 {
        print_to_builder(
            builder,
            "GLTF at '%' contains % scenes, but only 1 scene is supported\n",
            path,
            gltf.scenes.count,
        );
    }
}

validate_textures_and_images :: (gltf: GLTF, builder: *String_Builder, path: string) {
    for gltf_texture: gltf.textures {
        // @AntiSpec
        // Textures should have a source in our implementation, though it's not required by the spec.
        if gltf_texture._source == ABSENT {
            print_to_builder(
                builder,
                "GLTF at '%' has texture '%' which doesn't have a source\n",
                path,
                gltf_texture.name,
            );
        }
    }

    for gltf_image: gltf.images {
        // @AntiSpec
        if starts_with(gltf_image._uri, "data:") {
            print_to_builder(
                builder,
                "GLTF at '%' got an image with 'data:' uri. We don't support it, sorry!\n",
                path,
            );
        }

        if !gltf_image._uri && gltf_image._buffer_view == ABSENT {
            print_to_builder(
                builder,
                "GLTF at '%' got an image without uri and without buffer view. We consider it malformed\n",
                path,
            );
        }
    }
}

validate_meshes :: (gltf: GLTF, builder: *String_Builder, path: string) {
    for gltf_mesh: gltf.meshes {
        for gltf_primitive: gltf_mesh.primitives {
            // @AntiSpec?
            // Every primitive should have a position
            if gltf_primitive.attributes._position == ABSENT {
                print_to_builder(
                    builder,
                    "GLTF at '%': Primitive of mesh '%' doesn't have POSITION attribute\n",
                    path,
                    gltf_mesh.name,
                );
            }

            // Indices accessor checks
            if gltf_primitive._indices != ABSENT {
                gltf_indices_accessor := gltf.accessors[gltf_primitive._indices];

                // Indices should be scalars
                if gltf_indices_accessor.type != .SCALAR {
                    print_to_builder(
                        builder,
                        "GLTF at '%': Primitive of mesh '%' got indices accessor whose type is '%' instead of SCALAR\n",
                        path,
                        gltf_mesh.name,
                        gltf_indices_accessor.type,
                    );
                }

                // Indices should be u16/u32
                if (
                    gltf_indices_accessor.component_type != .UNSIGNED_SHORT
                    && gltf_indices_accessor.component_type != .UNSIGNED_INT
                ) {
                    print_to_builder(
                        builder,
                        "GLTF at '%': Primitive of mesh '%' got indices accessor whose component type is '%' instead of u16/u32\n",
                        path,
                        gltf_mesh.name,
                        gltf_indices_accessor.component_type,
                    );
                }

                // Target should be ELEMENT_ARRAY_BUFFER, but can be omitted. So we check for ARRAY_BUFFER only.
                if (
                    gltf_indices_accessor._buffer_view != ABSENT
                    && gltf.buffer_views[gltf_indices_accessor._buffer_view].target == .ARRAY_BUFFER
                ) {
                    print_to_builder(
                        builder,
                        "GLTF at '%': Primitive of mesh '%' got buffer view into indices data that has a target of ARRAY_BUFFER\n",
                        path,
                        gltf_mesh.name,
                    );
                }

                // @AntiSpec?
                // Buffer view shouldn't have a byte stride
                if (
                    gltf_indices_accessor._buffer_view != ABSENT
                    && gltf.buffer_views[gltf_indices_accessor._buffer_view]._byte_stride != ABSENT
                ) {
                    print_to_builder(
                        builder,
                        "GLTF at '%': Primitive of mesh '%' got buffer view into indices data that has a stride\n",
                        path,
                        gltf_mesh.name,
                    );
                }
            }
        }
    }
}

validate_buffers :: (gltf: GLTF, builder: *String_Builder, path: string) {
    for gltf_buffer: gltf.buffers {
        // @AntiSpec
        if starts_with(gltf_buffer._uri, "data:") {
            print_to_builder(
                builder,
                "GLTF at '%' got a buffer with data uri. Sorry, we don't support it.\n",
                path,
            );
        }
    }
}

// @AntiSpec?
// If the first buffer doesn't have uri, we must have a buffer from glb.
// There should be only one such file.
validate_buffers_without_uris :: (gltf: GLTF, builder: *String_Builder, path: string) {
    buffers_without_uri_indices: [..]s64;
    for gltf_buffer: gltf.buffers {
        if !gltf_buffer._uri {
            array_add(*buffers_without_uri_indices, it_index);
        }
    }

    // Got a dangling buffer from gltf
    if buffers_without_uri_indices.count == 0 && gltf.loaded_buffer_from_glb {
        print_to_builder(
            builder,
            "GLTF at '%' got no buffers without uri, but it's got a buffer from glb\n",
            path,
        );

        return;
    }

    // Everything is fine
    if buffers_without_uri_indices.count == 0 {
        return;
    }

    // Can't have several buffers without uri as glb provides only one buffer.
    if buffers_without_uri_indices.count > 1 {
        print_to_builder(
            builder,
            "GLTF at '%' got '%' buffers without uri, expected not more than 1\n",
            path,
            buffers_without_uri_indices.count,
        );

        return;
    }

    // Okay, we've got only one buffer without uri.

    // We must have buffer from glb.
    if !gltf.loaded_buffer_from_glb {
        print_to_builder(
            builder,
            "GLTF at '%' got a buffer without uri, but doesn't have a buffer from glb\n",
            path,
        );

        return;
    }

    if (
        buffers_without_uri_indices.count == 1
        && gltf.loaded_buffer_from_glb
        && gltf.buffers[buffers_without_uri_indices[0]].byte_length != gltf.loaded_buffer_from_glb.count
    ) {
        print_to_builder(
            builder,
            "GLTF at '%' got 1 buffer without uri and a buffer from glb, but the buffers byte_length is not equal to the glb's\n",
            path,
        );

        return;
    }

    // Only the first buffer can be the one who's implicitly pointing to the buffer from glb.
    if buffers_without_uri_indices[0] != 0 {
        print_to_builder(
            builder,
            "GLTF at '%' got a buffer without uri, but it's not the first buffer, it's the '%' one\n",
            path,
            buffers_without_uri_indices[0],
        );

        return;
    }
}
