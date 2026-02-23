// Example: jai -quiet build.jai - --optimized +Autorun

#import "Basic";
#import "Compiler";
#import "Metaprogram_Plugins";
#import "File";
#import "String";

// Plugins
DEFAULT_PLUGINS_TO_CREATE :: Plugin_To_Create.[
    { name = "Check" },
];

// Paths
BUILD_ABSOLUTE_PAH := #run path_join(#filepath, ".build");
ENTRY_ABSOLUTE_PATH    := #run path_join(#filepath, "src", "main.jai");

// Notes
RUN_WHEN_READY_NOTE :: "RunWhenReady";

Config :: struct {
    // Flags: --debug, --optimized
    optimization_type: Optimization_Type;
    plugins_to_create: []Plugin_To_Create;
}

run_when_ready_procedures: [..]*Code_Procedure_Header;

#run,stallable {
    defer reset_temporary_storage();

    set_build_options_dc({
        do_output           = false,
        write_added_strings = true,
    });

    build_options_dc := get_build_options();

    ok, config := create_config(build_options_dc.compile_time_command_line);
    if !ok {
        log_error("Build configuration failed");
        return;
    }

    ok = build(build_options_dc, config);
    if !ok {
        log_error("Build failed");
    }
}

create_config :: (arguments: []string) -> ok: bool, Config {
    config: Config;
    unknown_flags: [..]string;
    unknown_flags.allocator = temp;

    for argument: arguments {
        if argument == {
            case "--optimized";
                config.optimization_type = .VERY_OPTIMIZED;
            case "--debug";
                config.optimization_type = .DEBUG;
            case;
                // If the command is not a plugin and not one of the above - it's unknown and it's not safe to build
                if !starts_with(argument, "+") {
                    array_add_if_unique(*unknown_flags, argument);
                }
        }
    }

    if unknown_flags.count > 0 {
        log_error("Encountered unknown command line flags: %", unknown_flags);
        return false, config;
    }

    ok, plugins_to_create := parse_plugin_arguments(arguments);
    if ok {
        array_add(*plugins_to_create, ..DEFAULT_PLUGINS_TO_CREATE);
        config.plugins_to_create = plugins_to_create;
    }

    return ok, config;
}

build :: (build_options_dc: Build_Options, config: Config) -> ok: bool {
    log("Building in % mode", config.optimization_type);

    for plugin_to_create: config.plugins_to_create {
        log("'%' plugin enabled", plugin_to_create.name);
    }

    workspace := compiler_create_workspace("Mechjet");
    if !workspace {
        log_error("Failed to create workspace for building");
        return false;
    }

    output_absolute_path := path_join(BUILD_ABSOLUTE_PAH, tprint("%", config.optimization_type),, temp);

    ok := make_directory_if_it_does_not_exist(output_absolute_path, recursive = true);
    if !ok {
        log_error("Failed to create build directory");
        return false;
    }

    // Build options
    {
        build_options := get_build_options(workspace);
        copy_commonly_propagated_fields(build_options_dc, *build_options);

        // Jails runs this routine for checking the code.
        #if #exists(JAILS_DIAGNOSTICS_BUILD) {
            build_options.output_type = .NO_OUTPUT;
        } else {
            build_options.output_type = .EXECUTABLE;
        }

        build_options.output_executable_name = "Mechjet";
        build_options.output_path = output_absolute_path;
        build_options.intermediate_path = output_absolute_path;
        #if OS == {
            case .MACOS;
                build_options.minimum_os_version = { major = 14, minor = 0 };
            case .LINUX;
                linker_arguments: [..]string;
                array_resize(
                    *linker_arguments,
                    build_options.additional_linker_arguments.count,
                );
                for *arg: linker_arguments {
                    arg.* = build_options.additional_linker_arguments[it_index];
                }
                array_add(
                    *linker_arguments,
                    "-L/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.1",
                );

                build_options.additional_linker_arguments = linker_arguments;
        }

        set_optimization(*build_options, config.optimization_type);

        set_build_options(build_options, workspace);
    }

    plugins: [..]*Metaprogram_Plugin;
    plugins.allocator = temp;
    ok = init_plugins(config.plugins_to_create, *plugins, workspace);
    array_free(config.plugins_to_create);
    if !ok {
        log_error("Failed to initialize plugins");
        return false;
    }

    intercept_flags: Intercept_Flags;

    for plugin: plugins {
        if plugin.before_intercept {
            plugin.before_intercept(plugin, *intercept_flags);
        }
    }

    compiler_begin_intercept(workspace, intercept_flags);

    for plugin: plugins {
        if plugin.add_source {
            plugin.add_source(plugin);
        }
    }

    add_build_file(ENTRY_ABSOLUTE_PATH, workspace);

    handle_compiler_messages(plugins, config, workspace);

    compiler_end_intercept(workspace);

    for plugin: plugins {
        if plugin.finish {
            plugin.finish(plugin);
        }

        if plugin.shutdown {
            plugin.shutdown(plugin);
        }
    }

    return true;
}

handle_compiler_messages :: (
    plugins: []*Metaprogram_Plugin,
    config: Config,
    workspace: Workspace,
) {
    while true {
        message := compiler_wait_for_message();

        for plugin: plugins {
            if plugin.message {
                plugin.message(plugin, message);
            }
        }

        handle_run_when_ready(message);
        handle_debug_constant(message, config, workspace);

        if message.kind == {
            case .COMPLETE;
                break;
        }
    }
}

handle_debug_constant :: (
    message: *Message,
    config: Config,
    workspace: Workspace,
) {
    if message.kind == {
        case .FILE;
            file := cast(*Message_File, message);
            if ends_with(file.fully_pathed_filename, "main.jai") {
                add_build_string(
                    tprint(
                        "DEBUG: bool : %;",
                        config.optimization_type <= .VERY_DEBUG
                    ),
                    workspace,
                    file
                );
            }
    }
}

handle_run_when_ready :: (message: *Message) {
    if message.kind == {
        case .TYPECHECKED;
            typechecked := cast(*Message_Typechecked) message;
            for tc: typechecked.procedure_headers {
                header := tc.expression;
                if has_note(header, RUN_WHEN_READY_NOTE) {
                    array_add(*run_when_ready_procedures, header);
                }
            }
        case .PHASE;
            phase := cast(*Message_Phase) message;
            if phase.phase == .TYPECHECKED_ALL_WE_CAN {
                for run_when_ready_procedures {
                    s := tprint("#run %();", it.name);
                    add_build_string(s, message.workspace);
                }

                array_reset(*run_when_ready_procedures);
            }
    }
}

has_note :: (header: *Code_Procedure_Header, note: string) -> bool {
    for header.notes {
        if it.text == note {
            return true;
        }
    }

    return false;
}
