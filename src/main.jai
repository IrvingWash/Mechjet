#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
#import "Math";
Engine :: #import "Engine"()(DEBUG = DEBUG);
GLTF :: #import "GLTF";

Camera :: struct {
    position: Vector3;
    target:   Vector3;
    up:       Vector3 = { 0, 1, 0 };

    fov_radians: float;
    z_near: float;
    z_far:  float;
}

main :: () {
    #if DEBUG {
        defer report_memory_leaks();
    }

    setup_formatting();

    ok := Engine.init("Mechjet", 800, 600);
    assert(ok);
    defer Engine.deinit();

    gltf_converter := GLTF.create_converter();
    error, triangle_scene := GLTF.load_scene(gltf_converter, "modules/GLTF/assets/triangle_glb/triangle.glb");
    assert(error == "", "Failed to load triangle");
    GLTF.destroy_converter(gltf_converter);
    toolbox := Engine.get_toolbox();
    triangle_model := Engine.create_model(triangle_scene, toolbox.device, toolbox.queue);
    defer Engine.destroy_model(*triangle_model);
    GLTF.release_scene(*triangle_scene);

    while !Engine.should_quit() {
        Engine.begin_frame();

        Engine.start_drawing(
            Camera.{
                position = { 0, 3, 0 },
                fov_radians = Engine.deg_to_rad(60),
                z_near = 0.1,
                z_far = 100,
            },
        );

        Engine.draw_model(triangle_model);

        Engine.end_drawing();

        reset_temporary_storage();
    }
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
