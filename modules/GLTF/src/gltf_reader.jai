/*
This file reads `.gltf` files and simply parses their data into Jai types.
No manipulations are applied at all.
Everything here is meant for internal use.
*/

#scope_module

/*
    This procedure is called from a single place with a pool allocator.
    We don't need to free anything here.
    The pool allocator will be reset by the caller.
*/
read_gltf :: (path: string) -> error: string, GLTF {
    #if DO_SANITY_CHECKS {
        /*
            Just sanity checks.
            We call this procedure only from a single place which passes an absolute path
            and a pool allocator.
        */
        assert(
            context.allocator.proc == FP.flat_pool_allocator_proc,
            "This function can be used only with the Flat_Pool allocator.",
        );
        assert(
            is_absolute_path(path),
            "Path '%' is not an absolute path",
            path,
        );
    }

    gltf: GLTF;

    extension, ok := path_extension(path);
    if !ok {
        return tprint(
            "The provided path '%' is not a path to a file with an extension. We want a path to a .gltf or a .glb file\n",
            path,
        ),
        gltf;
    }

    if extension == {
        case GLTF_EXTENSION;
            ok, gltf = json_parse_file(path, GLTF);
            if !ok {
                return tprint("Failed to parse GLTF JSON data from '%'\n", path), gltf;
            }
        case GLB_EXTENSION;
            glb_data:, ok = read_entire_file(path);
            if !ok {
                return tprint("Failed to read .glb file from '%'\n", path), gltf;
            }

            error := parse_glb_data(glb_data, *gltf, path);
            if error {
                return error, gltf;
            }
        case;
            return tprint(
                "Unknown extension '%' at '%', only .gltf and .glb is supported\n",
                extension,
                path,
            ),
            gltf;
    }

    #if DO_SANITY_CHECKS {
        errors := validate_gltf(gltf, path);

        if errors {
            return errors, gltf;
        }
    }

    return "", gltf;
}



#scope_file

GLB_JSON_DATA_OFFSET :: size_of(GLB_Header) + size_of(GLB_Chunk_Info);
GLB_CHUNK_BOUNDARY_BYTE_SIZE :: 4;

GLTF_EXTENSION :: "gltf";
GLB_EXTENSION  :: "glb";

// Reading the JSON chunk into the passed parameter. Also adding the buffer from glb.
parse_glb_data :: (glb_data: string, gltf: *GLTF, path: string) -> error: string {
    header := cast(*GLB_Header, glb_data.data);

    #if DO_SANITY_CHECKS {
        error := validate_glb_header(header, path);
        if error {
            return error;
        }
    }

    // =========================================================================
    // Get the JSON
    // =========================================================================
    json_chunk_info := cast(*GLB_Chunk_Info, glb_data.data + size_of(GLB_Header));
    #if DO_SANITY_CHECKS {
        error = validate_glb_json_chunk(json_chunk_info, path);
        if error {
            return error;
        }
    }

    json_data := string.{
        data = glb_data.data + GLB_JSON_DATA_OFFSET,
        count = json_chunk_info.length,
    };

    ok:, gltf.* = json_parse_string(json_data, GLTF);
    if !ok {
        return tprint(
            "Failed to parse JSON from .glb at '%'",
            path,
        );
    }

    // =========================================================================
    // Get the buffer
    // =========================================================================
    json_chunk_padded_length := (json_chunk_info.length + GLB_CHUNK_BOUNDARY_BYTE_SIZE - 1) & ~cast(u32, GLB_CHUNK_BOUNDARY_BYTE_SIZE - 1);
    binary_chunk_offset := size_of(GLB_Header) + size_of(GLB_Chunk_Info) + json_chunk_padded_length;
    has_binary_chunk := header.length > binary_chunk_offset;

    // I guess this means that the binary data is in a separate .bin file?
    // Spec says this chunk should be omitted "when it is stored by other means".
    // Let's pretend these "means" include the separate .bin file.
    if !has_binary_chunk {
        return "";
    }

    binary_chunk_info := cast(*GLB_Chunk_Info, glb_data.data + binary_chunk_offset);
    #if DO_SANITY_CHECKS {
        error = validate_glb_binary_chunk(binary_chunk_info, path);
        if error {
            return error;
        }
    }

    gltf.loaded_buffer_from_glb = string.{
        data = glb_data.data + binary_chunk_offset + size_of(GLB_Chunk_Info),
        count = binary_chunk_info.length,
    };

    return "";
}

#import "Basic";
#import "String";
#import "Math";
#import "jaison";
FP :: #import "Flat_Pool";

#load "gltf_validator.jai";
#load "gltf.jai";
