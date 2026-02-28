// If multithreading, use one loader per thread. Which means call init once per thread.
GLTF_Converter :: struct {
    pool: FP.Flat_Pool;
    allocator: Allocator;
}

// Don't use the same converter in different threads.
create_converter :: () -> *GLTF_Converter {
    converter := New(GLTF_Converter);

    converter.allocator = {
        proc = FP.flat_pool_allocator_proc,
        data = *converter.pool,
    };

    return converter;
}

// Destroying the converter leaves the loaded scenes intact!
// Because converters are needed only for conversion. You might want your scene to outlive the converter.
destroy_converter :: (converter: *GLTF_Converter) {
    FP.fini(*converter.pool);

    free(converter);
}

// Only the scene is allocated by the default allocator in this procedure.
// Everything else's lifetimes are locked to the procedure's body by applying a pool allocator.
// If an error is returned - the scene is corrupted and should not be used.
// In such a case, the scene is released here, so if error != "", you don't need to do anything with the scene.
load_scene :: (converter: *GLTF_Converter, gltf_path: string) -> error: string, Scene {
    defer FP.reset(*converter.pool);

    scene: Scene;

    // =========================================================================
    // Preparing
    // =========================================================================

    absolute_path := gltf_path;
    if !is_absolute_path(gltf_path) {
        absolute_path =, ok := get_absolute_path(gltf_path,, converter.allocator);
        if !ok {
            return tprint(
                "Failed to get absolute path for '%'\n",
                gltf_path,
            ),
            scene;
        }
    }

    error, gltf := read_gltf(absolute_path,, converter.allocator);
    if error {
        return error, scene;
    }

    root_path := path_strip_filename(absolute_path,, converter.allocator);

    error =, loaded_gltf_buffers := load_gltf_buffers(
        gltf,
        root_path,,
        converter.allocator
    );
    if error {
        return error, scene;
    }

    // =========================================================================
    // Converting
    // =========================================================================

    gltf_scene := gltf.scenes[gltf._scene];

    scene.name = copy_string(gltf_scene.name);
    // @Robustness these reserves are correct situationally because we don't allow multiple scenes.
    // If we had/allowed more scenes, we'd reserve too much memory with the current code.
    array_reserve(*scene.nodes, gltf.nodes.count);
    array_reserve(*scene.meshes, get_gltf_primitives_count(gltf));
    array_reserve(*scene.materials, gltf.materials.count);

    for gltf_node_index: gltf_scene.nodes {
        error := convert_gltf_node(
            gltf,
            gltf_node_index,
            *scene,
            loaded_gltf_buffers,
            root_path,
        );
        if error {
            release_scene(*scene);

            return error, Scene.{};
        }
    }

    // @Robustness in a multiscene setup, if we want only one scene, we will save materials from other scenes
    for gltf_material: gltf.materials {
        error, material := convert_gltf_material(gltf, gltf_material, loaded_gltf_buffers, root_path);
        if error {
            release_scene(*scene);

            return error, Scene.{};
        }

        array_add(*scene.materials, material);
    }

    return "", scene;
}

// Should be called even after GLTF_Converter was destroyed.
// Scene's lifetime and GLTF_Converters lifetime are orthogonal.
release_scene :: (scene: *Scene) {
    free(scene.name);

    for node: scene.nodes {
        free(node.name);
        array_free(node.children_indices);
    }
    array_free(scene.nodes);

    for mesh: scene.meshes {
        free(mesh.name);
        array_free(mesh.vertices);
        array_free(mesh.indices);
    }
    array_free(scene.meshes);

    for material: scene.materials {
        free(material.name);
        free(material.pbr_metallic_roughness.base_color_texture.image_path);
        free(material.pbr_metallic_roughness.metallic_roughness_texture.image_path);
        free(material.normal_texture.texture.image_path);
        free(material.occlusion_texture.texture.image_path);
        free(material.emissive_texture.texture.image_path);

        free(material.pbr_metallic_roughness.base_color_texture.image_data);
        free(material.pbr_metallic_roughness.metallic_roughness_texture.image_data);
        free(material.normal_texture.texture.image_data);
        free(material.occlusion_texture.texture.image_data);
        free(material.emissive_texture.texture.image_data);
    }
    array_free(scene.materials);

    scene.* = {};
}



#scope_file

/*
gltf_node_index is used to subscript the list of nodes from the GLTF file.
Other indexes, without "gltf" in the name, are used to subscript the scene.
*/
convert_gltf_node :: (
    gltf:                GLTF,
    gltf_node_index:     s32,
    scene:               *Scene,
    loaded_gltf_buffers: []Loaded_GLTF_Buffer,
    root_path:           string,
    parent_node_index:   s32                   = ABSENT,
) -> error: string, converted_node_index: s32 {
    gltf_node := gltf.nodes[gltf_node_index];

    node: Node = {
        name            = copy_string(gltf_node.name),
        parent_index    = parent_node_index,
        local_transform = extract_gltf_node_transform(gltf_node),
    };

    // =========================================================================
    // Converting meshes (primitives)
    // =========================================================================
    if gltf_node._mesh != ABSENT {
        gltf_mesh := gltf.meshes[gltf_node._mesh];

        // We are going to add meshes to the scene, so the current count is exactly where the first mesh will be placed.
        node.first_mesh_index = cast(s32, scene.meshes.count);
        // The meshes of this node are placed contiguously. We map GLTF's primitives to our meshes
        node.mesh_count = cast(s32, gltf_mesh.primitives.count);

        common_name := gltf_mesh.name;

        for gltf_primitive: gltf_mesh.primitives {
            error, mesh := convert_gltf_primitive_into_mesh(
                gltf,
                gltf_primitive,
                loaded_gltf_buffers,
                root_path,
                common_name,
            );

            array_add(
                *scene.meshes,
                mesh,
            );

            if error {
                return error, -1;
            }
        }
    }

    // At this point we have filled all the info for the node except it's children
    // It would be more readable if we added the node into the scene at the end of this procedure,
    // after we added the children into the node.
    // But that wouldn't work because we can correctly get the index of this node inside the scene only right now, before converting child nodes.
    array_add(*scene.nodes, node);

    // =========================================================================
    // Converting children
    // =========================================================================
    current_node_index := scene.nodes.count - 1;

    for gltf_child_index: gltf_node.children {
        error, converted_node_index := convert_gltf_node(
            gltf,
            gltf_child_index,
            scene,
            loaded_gltf_buffers,
            root_path,
            cast(s32, current_node_index),
        );

        if error {
            return error, cast(s32, current_node_index);
        }

        array_add(
            *scene.nodes[current_node_index].children_indices,
            converted_node_index
        );
    }

    return "", cast(s32, current_node_index);
}

convert_gltf_primitive_into_mesh :: (
    gltf:                GLTF,
    gltf_primitive:      GLTF_Mesh.Primitive,
    loaded_gltf_buffers: []Loaded_GLTF_Buffer,
    root_path:           string,
    common_name:         string,
) -> error: string, Mesh {
    mesh: Mesh = {
        name = copy_string(common_name),
        mode = gltf_primitive.mode,
        material_index = gltf_primitive._material,
    };

    // =========================================================================
    // Indices
    // =========================================================================
    if gltf_primitive._indices != ABSENT {
        gltf_accessor := gltf.accessors[gltf_primitive._indices];

        error:, mesh.indices = parse_gltf_index_attribute(
            gltf,
            gltf_accessor,
            loaded_gltf_buffers,
        );
        if error {
            return error, mesh;
        }
    }

    // =========================================================================
    // Positions
    // =========================================================================
    {
        gltf_accessor := gltf.accessors[gltf_primitive.attributes._position];

        error, positions := parse_gltf_attribute(
            gltf,
            gltf_accessor,
            loaded_gltf_buffers,
            Vector3,
        );

        if error {
            return error, mesh;
        }

        array_resize(*mesh.vertices, positions.count);

        if gltf_accessor.max.count == 3 && gltf_accessor.min.count == 3 {
            mesh.max_position = { gltf_accessor.max[0], gltf_accessor.max[1], gltf_accessor.max[2] };
            mesh.min_position = { gltf_accessor.min[0], gltf_accessor.min[1], gltf_accessor.min[2] };
        }

        for position: positions {
            mesh.vertices[it_index].position = position;
        }
        array_free(positions);
    }

    // =========================================================================
    // Normals
    // =========================================================================
    if gltf_primitive.attributes._normal != ABSENT {
        gltf_accessor := gltf.accessors[gltf_primitive.attributes._normal];

        error, normals := parse_gltf_attribute(
            gltf,
            gltf_accessor,
            loaded_gltf_buffers,
            Vector3,
        );

        if error {
            return error, mesh;
        }

        for normal: normals {
            mesh.vertices[it_index].normal = normal;
        }
        array_free(normals);
    }

    // =========================================================================
    // Texture coordinates
    // =========================================================================
    if gltf_primitive.attributes._texcoord_0 != ABSENT {
        gltf_accessor := gltf.accessors[gltf_primitive.attributes._texcoord_0]; 

        error, uvs := parse_gltf_attribute(
            gltf,
            gltf_accessor,
            loaded_gltf_buffers,
            Vector2,
        );

        if error {
            return error, mesh;
        }

        for uv: uvs {
            mesh.vertices[it_index].uv = uv;
        }
        array_free(uvs);
    }

    return "", mesh;
}

parse_gltf_attribute :: (
    gltf: GLTF,
    gltf_accessor: GLTF_Accessor,
    loaded_gltf_buffers: []Loaded_GLTF_Buffer,
    $Target_Type: Type,
) -> error: string, [..]Target_Type
#modify {
    return Target_Type == Vector2 || Target_Type == Vector3 || IsScalar(Target_Type);
}
{
    #if DO_SANITY_CHECKS {
        if #complete gltf_accessor.type == {
            case .VEC2;
                assert(
                    Target_Type == Vector2,
                    "Wanted accessor of type '%', but got '%'",
                    Target_Type,
                    gltf_accessor.type,
                );
            case .VEC3;
                assert(
                    Target_Type == Vector3,
                    "Wanted accessor of type '%', but got '%'",
                    Target_Type,
                    gltf_accessor.type,
                );
            case .SCALAR;
                assert(
                    IsScalar(Target_Type),
                    "Wanted accessor of type '%', but got '%'",
                    Target_Type,
                    gltf_accessor.type,
                );
            case .VEC4; #through;
            case .MAT2; #through;
            case .MAT3; #through;
            case .MAT4; #through;
            case .UNKNOWN;
                assert(
                    false,
                    "Wanted accessor of type '%', but got '%'",
                    Target_Type,
                    gltf_accessor.type,
                );
        }
    }

    result: [..]Target_Type;

    // @AntiSpec
    if gltf_accessor.sparse._count != ABSENT {
        return "Got a sparse attribute, we don't support sparse, sorry!", result;
    }

    array_resize(*result, gltf_accessor.count);

    // We don't have neither bufferView nor sparse for this accessor. Zero intializing as per the specification
    if gltf_accessor._buffer_view == ABSENT {
        return "", result;
    }

    _, type_byte_size := get_type_and_byte_size_from_gltf_component_type(gltf_accessor.component_type);

    gltf_buffer_view := gltf.buffer_views[gltf_accessor._buffer_view];
    loaded_gltf_buffer := loaded_gltf_buffers[gltf_buffer_view.buffer];

    start_offset :=  gltf_accessor.byte_offset + gltf_buffer_view.byte_offset;
    packed_stride := type_byte_size * get_component_count_per_container_from_accessor_type(gltf_accessor.type);

    step := ifx gltf_buffer_view._byte_stride != ABSENT
        then gltf_buffer_view._byte_stride
        else packed_stride;

    // Data is tightly packed (not interleaved), so we can pull a memcpy
    if step == packed_stride {
        bytes_to_copy := gltf_accessor.count * step;
        memcpy(
            result.data,
            loaded_gltf_buffer.data + start_offset,
            bytes_to_copy,
        );

        return "", result;
    }

    // It's an interleaved buffer, going the long way.
    for 0..(gltf_accessor.count - 1) {
        index_into_buffer := start_offset + it * step;

        pointer := cast(*Target_Type, loaded_gltf_buffer.data + index_into_buffer);

        result[it] = pointer.*;
    }

    return "", result;
}

parse_gltf_index_attribute :: (
    gltf: GLTF,
    gltf_accessor: GLTF_Accessor,
    loaded_gltf_buffers: []Loaded_GLTF_Buffer,
) -> error: string, [..]u32
{
    result: [..]u32;

    // @AntiSpec
    if gltf_accessor.sparse._count != ABSENT {
        return "Got a sparse indices attribute, we don't support sparse, sorry!", result;
    }

    array_resize(*result, gltf_accessor.count);

    // We don't have neither bufferView nor sparse for this accessor. Zero intializing as per the specification
    if gltf_accessor._buffer_view == ABSENT {
        return "", result;
    }

    // =========================================================================
    // Parsing
    // =========================================================================

    index_type,
    index_type_byte_size := get_type_and_byte_size_from_gltf_component_type(
        gltf_accessor.component_type,
    );

    gltf_buffer_view := gltf.buffer_views[gltf_accessor._buffer_view];
    loaded_gltf_buffer := loaded_gltf_buffers[gltf_buffer_view.buffer];

    start_offset := gltf_accessor.byte_offset + gltf_buffer_view.byte_offset;

    // If GLTF data is u32 too, we can just copy the memory
    if index_type == u32 {
        bytes_to_copy := gltf_accessor.count * index_type_byte_size;
        memcpy(
            result.data,
            loaded_gltf_buffer.data + start_offset,
            bytes_to_copy,
        );

        return "", result;
    }

    // Otherwise it's u16, we need to do some scary casting stuff.

    for 0..(gltf_accessor.count - 1) {
        index_into_buffer := start_offset + it * index_type_byte_size;

        pointer := cast(*u16, loaded_gltf_buffer.data + index_into_buffer);

        result[it] = cast(u32, pointer.*);
    }

    return "", result;
}

get_type_and_byte_size_from_gltf_component_type :: (gltf_component_type: GLTF_Accessor.Component_Type) -> Type, u8 {
    if #complete gltf_component_type == {
        case .BYTE;
            return s8, 1;
        case .UNSIGNED_BYTE;
            return u8, 1;
        case .SHORT;
            return s16, 2;
        case .UNSIGNED_SHORT;
            return u16, 2;
        case .UNSIGNED_INT;
            return u32, 4;
        case .FLOAT;
            return float32, 4;
        case .UNKNOWN;
            assert(false, "Invalid component type '%'", gltf_component_type);
    }

    assert(false, "This should never happen");
    return u8, 1;
}


convert_gltf_material :: (
    gltf: GLTF,
    gltf_material: GLTF_Material,
    loaded_gltf_buffers: []Loaded_GLTF_Buffer,
    root_path: string,
) -> error: string, Material {
    material: Material = {
        name = copy_string(gltf_material.name),
        double_sided = gltf_material.double_sided,
        alpha_mode = gltf_material.alpha_mode,
        alpha_cutoff = gltf_material.alpha_cutoff,
    };

    // =========================================================================
    // PBR Metallic Roughness
    // =========================================================================
    material.pbr_metallic_roughness = {
        base_color_factor.component = gltf_material.pbr_metallic_roughness.base_color_factor,
        metallic_factor = gltf_material.pbr_metallic_roughness.metallic_factor,
        roughness_factor = gltf_material.pbr_metallic_roughness.roughness_factor,
    };
    if gltf_material.pbr_metallic_roughness.base_color_texture._index != ABSENT {
        gltf_texture := gltf.textures[gltf_material.pbr_metallic_roughness.base_color_texture._index];

        error:, material.pbr_metallic_roughness.base_color_texture = convert_gltf_texture(
            gltf,
            gltf_texture,
            loaded_gltf_buffers,
            root_path,
        );
        if error {
            return error, material;
        }
    }
    if gltf_material.pbr_metallic_roughness.metallic_roughness_texture._index != ABSENT {
        gltf_texture := gltf.textures[gltf_material.pbr_metallic_roughness.metallic_roughness_texture._index];

        error:, material.pbr_metallic_roughness.metallic_roughness_texture = convert_gltf_texture(
            gltf,
            gltf_texture,
            loaded_gltf_buffers,
            root_path,
        );
        if error {
            return error, material;
        }
    }

    // =========================================================================
    // Normal Map
    // =========================================================================
    material.normal_texture = {
        scale = gltf_material.normal_texture.scale,
    };
    if gltf_material.normal_texture._index != ABSENT {
        gltf_texture := gltf.textures[gltf_material.normal_texture._index];

        error:, material.normal_texture.texture = convert_gltf_texture(
            gltf,
            gltf_texture,
            loaded_gltf_buffers,
            root_path,
        );
        if error {
            return error, material;
        }
    }

    material.occlusion_texture = {
        strength = gltf_material.occlusion_texture.strength,
    };
    if gltf_material.occlusion_texture._index != ABSENT {
        gltf_texture := gltf.textures[gltf_material.occlusion_texture._index];

        error:, material.occlusion_texture.texture = convert_gltf_texture(
            gltf,
            gltf_texture,
            loaded_gltf_buffers,
            root_path,
        );
        if error {
            return error, material;
        }
    }

    material.emissive_texture = {
        factor.component = gltf_material.emissive_factor,
    };
    if gltf_material.emissive_texture._index != ABSENT {
        gltf_texture := gltf.textures[gltf_material.emissive_texture._index];

        error:, material.emissive_texture.texture = convert_gltf_texture(
            gltf,
            gltf_texture,
            loaded_gltf_buffers,
            root_path,
        );
        if error {
            return error, material;
        }
    }

    return "", material;
}

convert_gltf_texture :: (
    gltf: GLTF,
    gltf_texture: GLTF_Texture,
    loaded_gltf_buffers: []Loaded_GLTF_Buffer,
    root_path: string,
) -> error: string, Material.Texture {
    texture: Material.Texture = ---;

    gltf_image   := gltf.images[gltf_texture._source];
    gltf_sampler := ifx gltf_texture._sampler != ABSENT
        then gltf.samplers[gltf_texture._sampler]
        else GLTF_Sampler.{};

    texture = {
        mag_filter = gltf_sampler.mag_filter,
        min_filter = gltf_sampler.min_filter,
        wrap_s     = gltf_sampler.wrap_s,
        wrap_t     = gltf_sampler.wrap_t,
    };

    if gltf_image._uri {
        texture.image_path = path_join(root_path, gltf_image._uri);
    } else {
        gltf_buffer_view := gltf.buffer_views[gltf_image._buffer_view];
        gltf_buffer := loaded_gltf_buffers[gltf_buffer_view.buffer];

        texture.image_data = copy_string(
            string.{
                count = gltf_buffer_view.byte_length,
                data = gltf_buffer.data + gltf_buffer_view.byte_offset,
            },
        );
    }

    return "", texture;
}

extract_gltf_node_transform :: (gltf_node: GLTF_Node) -> Matrix4 {
    /*
        We don't know what the gltf file contained - the matrix or a TRS set.
        So we proceed in three stages:
        1. See if the matrtix is not an identity matrix.
        If so - it was present in the file, because otherwise GLTF_Reader would return the identity matrix.
        Return the matrix, we're lucky!
        But if it's an identity matrix - we don't know whether it's an actual identity matrix from the file or just the default from the GLTF_Reader.
        We need more evidence.
        2. Now we need to check whether the separate TRS fields were present in the file.
        If we are here, we know that the matrix from the file doesn't transform anything.
        So we check the TRS.
        :If all of them are the defaults too - we just return Matrix_Identity, as we know for sure neither the matrix nor the TRS are trying to transform.
        3. If something from the TRS gang is not at it's default, we know for sure, there is a transformation. We calculate it and return.
    */

    // Step 1
    gltf_node_transform: Matrix4 = ---;
    gltf_node_transform.floats = gltf_node.matrix;
    gltf_node_transform = transpose(gltf_node_transform); // Transpose because Jai has row-major matrices, but the data from gltf comes in column-major.

    if gltf_node_transform != Matrix4_Identity {
        return gltf_node_transform;
    }

    // Step 2
    gltf_node_translation: Vector3;
    gltf_node_rotation:    Quaternion;
    gltf_node_scale:       Vector3;

    gltf_node_translation.component = gltf_node.translation;
    gltf_node_rotation.component    = gltf_node.rotation;
    gltf_node_scale.component       = gltf_node.scale;

    if (
        gltf_node_translation == Vector3.{}
        && gltf_node_scale == Vector3.{ 1, 1, 1 }
        && gltf_node_rotation == Quaternion.{}
    ) {
        return Matrix4_Identity;
    }

    // Step 3
    translation := make_translation_matrix4(gltf_node_translation);
    rotation    := rotation_matrix(Matrix4, gltf_node_rotation);
    _scale      := make_scale_matrix4(gltf_node_scale);

    return translation * rotation * _scale;
}

Loaded_GLTF_Buffer :: #type,isa string;

load_gltf_buffers :: (gltf: GLTF, root_path: string) -> error: string, []Loaded_GLTF_Buffer {
    #if DO_SANITY_CHECKS {
        assert(
            context.allocator.proc == FP.flat_pool_allocator_proc,
            "This procedure expects to allocate into a pool allocator.",
        );
    }

    result: [..]Loaded_GLTF_Buffer;
    array_resize(*result, gltf.buffers.count);

    has_added_loaded_buffer_from_glb: bool;
    for gltf_buffer: gltf.buffers {
        if (
            !gltf_buffer._uri
            && gltf.loaded_buffer_from_glb
            && !has_added_loaded_buffer_from_glb
        ) {
            result[it_index] = cast(Loaded_GLTF_Buffer, gltf.loaded_buffer_from_glb);

            has_added_loaded_buffer_from_glb = true;

            continue;
        }

        absolute_buffer_path := path_join(root_path, gltf_buffer._uri);
        bytes, ok := read_entire_file(absolute_buffer_path);
        if !ok {
            return tprint(
                "Failed to read buffer from '%'\n",
                absolute_buffer_path,
            ),
            result;
        }

        result[it_index] = cast(Loaded_GLTF_Buffer, bytes);
    }

    return "", result;
}

get_gltf_primitives_count :: (gltf: GLTF) -> u32 {
    result: u32;

    for mesh: gltf.meshes {
        result += cast(u32, mesh.primitives.count);
    }

    return result;
}

get_component_count_per_container_from_accessor_type :: (accessor_type: GLTF_Accessor.Accessor_Type) -> u8 {
    if #complete accessor_type == {
        case .SCALAR;
            return 1;
        case .VEC2;
            return 2;
        case .VEC3;
            return 3;
        case .VEC4;
            return 4;
        case .MAT2;
            return 4;
        case .MAT3;
            return 9;
        case .MAT4;
            return 16;
        case .UNKNOWN;
            assert(false, "Unknown accessor type '%'", accessor_type);
    }

    assert(false, "This should never happen");

    return 0;
}

#import "Basic";
#import "File";
#import "String";
FP :: #import "Flat_Pool";

#load "gltf_reader.jai";
