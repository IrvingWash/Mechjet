Model_Handle :: #type,isa int;



#scope_module

Asset_Storage_Handle :: #type *void;

init_asset_storage :: () -> Asset_Storage_Handle {
    storage := New(Asset_Storage);

    return storage;
}

deinit_asset_storage :: (handle: Asset_Storage_Handle) {
    storage := cast(*Asset_Storage, handle);

    if storage.gltf_converter {
        GLTF.destroy_converter(storage.gltf_converter);
    }

    for *model: storage.model_storage.models {
        Renderer.destroy_model(model);
    }
    array_free(storage.model_storage.models);

    for _, path: storage.model_storage.map {
        free(path);
    }
    table_reset(*storage.model_storage.map);
    deinit(*storage.model_storage.map);

    for texture, path: storage.textures {
        free(path);
        Renderer.destroy_texture(texture);
    }
    deinit(*storage.textures);

    free(storage);
}

get_model_handle_from_storage :: (handle: Asset_Storage_Handle, renderer: Renderer.Renderer_Handle, path: string) -> ok: bool, Model_Handle {
    absolute_path, ok := get_absolute_path(path);
    if !ok {
        log_error("Failed to get absolute path for '%'", path);
        return false, -1;
    }

    storage := cast(*Asset_Storage, handle);

    ok =, handle := table_find(*storage.model_storage.map, absolute_path);
    if ok {
        return true, handle;
    }

    // @Todo this beats the point of having converters.
    // Maybe we should have a bulk_load_models or something.
    // Which handle multithreaded asset loading itself.
    if !storage.gltf_converter {
        storage.gltf_converter = GLTF.create_converter();
    }

    error, gltf_scene := GLTF.load_scene(storage.gltf_converter, absolute_path);
    if error != "" {
        log_error("Failed to load GLTF from '%': '%'", absolute_path, error);

        return false, -1;
    }
    defer GLTF.release_scene(*gltf_scene);

    model_creation_data := convert_gltf_scene_to_model_creation_data(storage, renderer, gltf_scene);
    defer Renderer.destroy_model_creation_data(*model_creation_data);
    model := Renderer.create_model(renderer, model_creation_data);

    array_add(*storage.model_storage.models, model);

    handle = cast(Model_Handle, storage.model_storage.models.count - 1);

    table_set(*storage.model_storage.map, copy_string(absolute_path), handle);

    return true, handle;
}

resolve_model_handle_in_storage :: (storage_handle: Asset_Storage_Handle, model_handle: Model_Handle) -> Renderer.Model {
    storage := cast(*Asset_Storage, storage_handle);

    return storage.model_storage.models[model_handle];
}



#scope_file

Asset_Storage :: struct {
    model_storage: Model_Storage;
    textures: Table(string, Renderer.Texture);
    gltf_converter: *GLTF.GLTF_Converter;
}

Model_Storage :: struct {
    models: [..]Renderer.Model;
    map:    Table(string, Model_Handle);
}

convert_gltf_scene_to_model_creation_data :: (
    storage: *Asset_Storage,
    renderer: Renderer.Renderer_Handle,
    gltf_scene: GLTF.Scene,
) -> Renderer.Model_Creation_Data {
    model_creation_data: Renderer.Model_Creation_Data;

    { // Nodes
        array_resize(*model_creation_data.nodes, gltf_scene.nodes.count);
        for gltf_node, gltf_node_index: gltf_scene.nodes {
            model_creation_data.nodes[gltf_node_index] = {
                parent_index = gltf_node.parent_index,
                first_mesh_index = gltf_node.first_mesh_index,
                mesh_count = cast(u32, gltf_node.mesh_count),
                local_transform = gltf_node.local_transform,
            };

            array_resize(*model_creation_data.nodes[gltf_node_index].children_indices, gltf_node.children_indices.count);
            for gltf_child_index, gltf_child_index_index: gltf_node.children_indices {
                model_creation_data.nodes[gltf_node_index].children_indices[gltf_child_index_index] = cast(u32, gltf_child_index);
            }
        }
    }

    { // Meshes
        array_resize(*model_creation_data.meshes, gltf_scene.meshes.count);
        for gltf_mesh, gltf_mesh_index: gltf_scene.meshes {
            mesh := *model_creation_data.meshes[gltf_mesh_index];

            { // Vertices
                array_resize(
                    *mesh.vertices,
                    gltf_mesh.vertices.count,
                );
                for gltf_vertex, gltf_vertex_index: gltf_mesh.vertices {
                    mesh.vertices[gltf_vertex_index] = {
                        position = gltf_vertex.position,
                        normal = gltf_vertex.normal,
                        uv = gltf_vertex.uv,
                    };
                }
            }

            { // Indices
                array_resize(
                    *mesh.indices,
                    gltf_mesh.indices.count,
                );
                for gltf_index, gltf_index_index: gltf_mesh.indices {
                    mesh.indices[gltf_index_index] = gltf_index;
                }
            }

            // Material
            if gltf_mesh.material_index != -1 {
                mesh.material = convert_gltf_material(storage, renderer, gltf_scene.materials[gltf_mesh.material_index]);
            }
        }
    }

    return model_creation_data;
}

convert_gltf_material :: (
    storage: *Asset_Storage,
    renderer: *Renderer.Renderer_Handle,
    gltf_material: GLTF.Material,
) -> Renderer.Material {
    material: Renderer.Material;

    { // PBR
        gltf_pbr := gltf_material.pbr_metallic_roughness;

        material.params
            .base_color_factor = gltf_pbr.base_color_factor;

        // Base color
        if gltf_pbr.base_color_texture.image_path {
            gltf_base_color_texture := gltf_pbr.base_color_texture;

            ok, texture := table_find(*storage.textures, gltf_base_color_texture.image_path);
            if !ok {
                texture = Renderer.create_base_color_texture(
                    renderer,
                    gltf_base_color_texture.image_path,
                    convert_gltf_wrap_mode(gltf_base_color_texture.wrap_s),
                    convert_gltf_wrap_mode(gltf_base_color_texture.wrap_t),
                    convert_gltf_mag_filter(gltf_base_color_texture.mag_filter),
                    convert_gltf_min_filter(gltf_base_color_texture.min_filter),
                );

                table_set(*storage.textures, copy_string(gltf_base_color_texture.image_path), texture);
            }

            material.base_color_texture = texture;
        }
    }

    return material;
}

convert_gltf_wrap_mode :: (gltf_wrap_mode: GLTF.Material.Texture.Wrap_Mode) -> Renderer.Address_Mode {
    if #complete gltf_wrap_mode == {
        case .CLAMP_TO_EDGE;
            return .ClampToEdge;
        case .MIRRORED_REPEAT;
            return .MirrorRepeat;
        case .REPEAT;
            return .Repeat;
    }
}

convert_gltf_mag_filter :: (gltf_mag_filter: GLTF.Material.Texture.Mag_Filter) -> Renderer.Filter_Mode {
    if #complete gltf_mag_filter == {
        case .UNKNOWN;
            log_error("Got UNKNOWN mag filter from GLTF, defaulted to linear");
            return .Linear;
        case .NEAREST;
            return .Nearest;
        case .LINEAR;
            return .Linear;
    }
}

convert_gltf_min_filter :: (gltf_min_filter: GLTF.Material.Texture.Min_Filter) -> Renderer.Filter_Mode {
    if #complete gltf_min_filter == {
        case .UNKNOWN;
            log_error("Got UNKNOWN min filter from GLTF, defaulted to nearest");
            return .Nearest;
        case .NEAREST;
            return .Nearest;
        case .LINEAR;
            return .Linear;
        case .NEAREST_MIPMAP_NEAREST; #through;
        case .LINEAR_MIPMAP_NEAREST; #through;
        case .NEAREST_MIPMAP_LINEAR; #through;
        case .LINEAR_MIPMAP_LINEAR;
            log_error("Got a mipmap filter from GLTF. Not sure how to use it yet, defaulted to nearest");
            return .Nearest;
    }
}

#import "Basic";
#import "Hash_Table";
#import "File";
Renderer :: #import "Renderer";
GLTF :: #import "GLTF";
