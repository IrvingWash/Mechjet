// jai ./bulid_example.jai - minimal_opengl_triangle +Autorun

#import "Basic";
#import "Compiler";
#import "String";
#import "File";
#import "File_Utilities";
#import "Metaprogram_Plugins";

Config :: struct {
    example: string;
    plugins_to_create: [..]Plugin_To_Create;
    plugins_to_create.allocator = temp;
}

BUILD_PATH_BASE :: "build";
ENTRY_POINT_PATH_BASE :: "examples";
MAIN_FILE_PATH :: "src/main.jai";
EXECUTABLE_NAME :: "target";

#run,stallable {
    set_build_options_dc({
        do_output = false,
        write_added_strings = false,
    });

    build_options_dc := get_build_options();

    args := build_options_dc.compile_time_command_line;
    if args.count == 0 {
        terminate("No arguments provided\n");
    }

    config := make_config_from_args(args);

    if config.example == "" {
        terminate("No example provided\n");
    }

    build(config.example, build_options_dc, config.plugins_to_create);

    reset_temporary_storage();
}

make_config_from_args :: (args: []string) -> Config {
    config: Config;

    if args.count > 0 {
        config.example = args[0];
    }

    ok, plugins_to_create := parse_plugin_arguments(args);
    assert(ok, "Failed to parse plugin arguments");
    config.plugins_to_create = plugins_to_create;

    return config;
}

build :: (
    example_name: string,
    build_options_dc: Build_Options,
    plugins_to_create: []Plugin_To_Create,
) {
    workspace := compiler_create_workspace(example_name);

    print("Building example '%'\n", example_name);

    build_dir_path := tprint(
        "%/%/DEBUG",
        BUILD_PATH_BASE,
        example_name,
    );

    build_options := get_build_options(workspace);

    copy_commonly_propagated_fields(build_options_dc, *build_options);
    {
        using build_options;

        output_type = .EXECUTABLE;
        output_executable_name = EXECUTABLE_NAME;
        output_path, intermediate_path = build_dir_path;
        import_path = make_import_paths(import_path);
    }
    set_optimization(*build_options, .DEBUG);

    set_build_options(build_options, workspace);

    make_directory_if_it_does_not_exist(build_dir_path, recursive = true);

    plugins: [..]*Metaprogram_Plugin;
    plugins.allocator = temp;
    ok := init_plugins(plugins_to_create, *plugins, workspace);
    assert(ok, "Failed to create plugins");

    intercept_flags: Intercept_Flags;

    for plugin: plugins {
        if plugin.before_intercept {
            plugin.before_intercept(plugin, *intercept_flags);
        }
    }

    compiler_begin_intercept(workspace);

    for plugin: plugins {
        if plugin.add_source {
            plugin.add_source(plugin);
        }
    }

    add_build_file(
        tprint(
            "%/%/%",
            ENTRY_POINT_PATH_BASE,
            example_name,
            MAIN_FILE_PATH,
        ),
        workspace,
    );

    on_compiler_message(plugins);

    compiler_end_intercept(workspace);

    for plugin: plugins {
        if plugin.finish {
            plugin.finish(plugin);
        }

        if plugin.shutdown {
            plugin.shutdown(plugin);
        }
    }
}

on_compiler_message :: (plugins: []*Metaprogram_Plugin) {
    while true {
        message := compiler_wait_for_message();

        for plugin: plugins {
            if plugin.message {
                plugin.message(plugin, message);
            }
        }

        if message.kind == {
            case .COMPLETE;
                break;
        }
    }
}

terminate :: (format_string: string, args: .. Any) {
    print(format_string, ..args, to_standard_error = true);
    exit(1);
}

make_import_paths :: (import_paths: []string) -> []string {
    result: [..]string;
    result.allocator = temp;

    for path: import_paths {
        array_add(*result, path);
    }

    array_add(*result, "../../../modules");

    return result;
}
