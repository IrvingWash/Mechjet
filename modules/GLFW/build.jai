#import "Basic";
#import "Compiler";
#import "Process";
#import "File";
#import "String";

ABSOLUTE_SOURCE_PATH :: #run path_join(#filepath, "glfw");

ABSOLUTE_CMAKE_GENERATION_PATH :: #run path_join(#filepath, ".cmake");

ABSOLUTE_OUTUPT_PATH :: #run path_join(#filepath, tprint("%", OS));

#run,stallable {
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

    ok := make_directory_if_it_does_not_exist(ABSOLUTE_OUTUPT_PATH);
    if !ok {
        log_error("Failed to create output directory");
        return;
    }

    ok = make_directory_if_it_does_not_exist(ABSOLUTE_CMAKE_GENERATION_PATH);
    if !ok {
        log_error("Failed to create directory for cmake generated files");
        return;
    }

    array_add(
        *config_command,
        "cmake",
        ABSOLUTE_SOURCE_PATH,
        tprint("-B %", ABSOLUTE_CMAKE_GENERATION_PATH),
        tprint("-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=%", ABSOLUTE_OUTUPT_PATH),
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
        ABSOLUTE_CMAKE_GENERATION_PATH,
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
