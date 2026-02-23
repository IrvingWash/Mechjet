#import "Basic";
#import "Compiler";
#import "Process";
#import "File";

ABSOLUTE_SOURCE_PATH :: #run -> string {
    return get_absolute_path("glfw");
}

CMAKE_GENERATION_DIR :: ".cmake";

#if OS == {
    case .MACOS;
        PLATFORM_NAME :: "macos";
    case .LINUX;
        PLATFORM_NAME :: "linux";
    case .WINDOWS;
        PLATFORM_NAME :: "windows";
}

#run {
    set_build_options_dc({
        do_output           = false,
        write_added_strings = false,
    });

    build_glfw();

    reset_temporary_storage();
}

build_glfw :: () {
    // =========================================================================
    // Configure
    // =========================================================================
    config_command: [..]string;
    config_command.allocator = temp;

    ok := make_directory_if_it_does_not_exist(PLATFORM_NAME);
    if !ok {
        log_error("Failed to create binary directory");
        return;
    }

    absolute_binary_path := get_absolute_path(PLATFORM_NAME);
    cmake_generation_absolute_path := tprint("%%", #filepath, CMAKE_GENERATION_DIR);

    ok = make_directory_if_it_does_not_exist(cmake_generation_absolute_path);
    if !ok {
        log_error("Failed to create directory for cmake generated files");
        return;
    }

    array_add(
        *config_command,
        "cmake",
        ABSOLUTE_SOURCE_PATH,
        tprint("-B %", cmake_generation_absolute_path),
        tprint("-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=%", absolute_binary_path),
        "-DBUILD_SHARED_LIBS=OFF",
        "-DGLFW_LIBRARY_TYPE=STATIC",
        "-DGLFW_BUILD_EXAMPLES=OFF",
        "-DGLFW_BUILD_TESTS=OFF",
        "-DGLFW_BUILD_DOCS=OFF",
    );
    #if OS == {
        case .MACOS;
            array_add(
                *config_command,
                "-DCMAKE_OSX_DEPLOYMENT_TARGET=14.0",
                "-DGLFW_BUILD_COCOA=ON",
            );
        case .LINUX;
            array_add(
                *config_command,
                "-DGLFW_BUILD_X11=ON",
            );
    }
    run_command(
        ..config_command,
        working_directory = #filepath,
        capture_and_return_output = true,
        print_captured_output     = true,
    );

    // =====================================================================
    // Build
    // =====================================================================
    build_command: [..]string;
    build_command.allocator = temp;
    array_add(
        *build_command,
        "cmake",
        "--build",
        cmake_generation_absolute_path,
        "--config",
        "Release",
    );

    run_command(
        ..build_command,
        working_directory = #filepath,
        capture_and_return_output = true,
        print_captured_output     = true,
    );
}
