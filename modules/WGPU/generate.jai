ABSOLUTE_WGPU_NATIVE_PATH :: #run make_absolute_path("wgpu-native");

#if OS == {
    case .LINUX;
        STATIC_LIB_NAME :: "libwgpu_native.a";
    case .MACOS;
        STATIC_LIB_NAME :: "libwgpu_native.a";
    case .WINDOWS;
        STATIC_LIB_NAME :: "wgpu_native.lib";
    case;
        #assert false;
}

BUILD_DIR :: #run tprint("%", OS);
ABSOLUTE_BUILD_PATH :: #run make_absolute_path(BUILD_DIR);

#run,stallable {
    set_build_options_dc({
        do_output           = false,
        write_added_strings = false,
    });

    ok := build();
    if !ok {
        log_error("Failed to build binaries.");
        return;
    }

    ok = generate();
    if !ok {
        log_error("Failed to generate bindings.");
        return;
    }
}

generate :: () -> ok: bool {
    output_file_name: string;
    options: Generate_Bindings_Options;

    array_add(*options.library_search_paths, BUILD_DIR);

    array_add(*options.libraries, { filename = path_strip_extension(STATIC_LIB_NAME) });

    array_add(
        *options.source_files,
        path_join(
            ABSOLUTE_WGPU_NATIVE_PATH,
            "ffi",
            "wgpu.h",
        ),
    );

    array_add(
        *options.include_paths,
        path_join(
            ABSOLUTE_WGPU_NATIVE_PATH,
            "ffi",
            "webgpu-headers",
        ),
    );

    array_add(
        *options.strip_prefixes,
        "WGPU",
        "wgpu",
        "WGPU_",
        "wgpu_",
    );

    #if OS == {
        case .LINUX;
            output_file_name = "linux.jai";
        case .MACOS;
            output_file_name = "macos.jai";
        case .WINDOWS;
            output_file_name = "windows.jai";
        case;
            assert(false, "'%' is not supported");
    }

    return generate_bindings(options, output_file_name);
}

build :: () -> ok: bool {
    ok := make_directory_if_it_does_not_exist(ABSOLUTE_BUILD_PATH, true);
    assert(
        ok,
        "Failed to create build directory at directory %",
        ABSOLUTE_BUILD_PATH,
    );

    build_command: [..]string;

    array_add(
        *build_command,
        "cargo",
        "build",
        "--release",
    );

    result := run_command(
        ..build_command,
        working_directory = ABSOLUTE_WGPU_NATIVE_PATH,
    );
    if result.exit_code == 101 {
        return false;
    }

    copy_file(
        path_join(
            ABSOLUTE_WGPU_NATIVE_PATH,
            "target",
            "release",
            STATIC_LIB_NAME,
        ),
        path_join(
            ABSOLUTE_BUILD_PATH,
            STATIC_LIB_NAME,
        ),
    );

    return true;
}

make_absolute_path :: (end: string) -> string #compile_time {
    return path_join(#filepath, end);
}

#import "Basic";
#import "Compiler";
#import "String";
#import "File";
#import "Process";
#import "File_Utilities";
#import "Bindings_Generator";
