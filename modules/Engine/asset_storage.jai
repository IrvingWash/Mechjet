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

    storage.* = {};
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

    model := Renderer.create_model_from_gltf_scene(renderer, gltf_scene);

    GLTF.release_scene(*gltf_scene);

    array_add(*storage.model_storage.models, model);

    handle = cast(Model_Handle, storage.model_storage.models.count - 1);

    table_set(*storage.model_storage.map, copy_string(absolute_path), handle);

    return true, handle;
}

resolve_model_handle_in_storage :: (storage_handle: Asset_Storage_Handle, model_handle: Model_Handle) -> *Renderer.Model {
    storage := cast(*Asset_Storage, storage_handle);

    return *storage.model_storage.models[model_handle];
}



#scope_file

Asset_Storage :: struct {
    model_storage: Model_Storage;
    gltf_converter: *GLTF.GLTF_Converter;
}

Model_Storage :: struct {
    models: [..]Renderer.Model;
    map:    Table(string, Model_Handle);
}

#import "Basic";
#import "Hash_Table";
#import "File";
Renderer :: #import "Renderer";
GLTF :: #import "GLTF";
