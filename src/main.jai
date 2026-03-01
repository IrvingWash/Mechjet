#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
#import "Math";
Engine :: #import "Engine"()(DEBUG = DEBUG);

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

    ok =, lamp_handle := Engine.get_model_handle("modules/GLTF/assets/lantern_glb/lantern.glb");
    assert(ok);

    ok =, mech_handle := Engine.get_model_handle("modules/GLTF/assets/mech_glb/mech.glb");

    while !Engine.should_quit() {
        Engine.begin_frame();

        Engine.start_drawing(
            Camera.{
                position = { 0, 50, 50 },
                target   = { 0, 0, 0, },
                fov_radians = Engine.deg_to_rad(60),
                z_near = 0.1,
                z_far = 100,
            },
        );

        Engine.draw_model(Engine.resolve_model_handle(lamp_handle), Matrix4_Identity);
        Engine.draw_model(Engine.resolve_model_handle(lamp_handle), make_translation_matrix4({ 10, 0, 0 }));
        Engine.draw_model(Engine.resolve_model_handle(mech_handle), make_translation_matrix4({-10, 0, 0 }));
        Engine.draw_model(Engine.resolve_model_handle(mech_handle), make_translation_matrix4({-10, 10, 0 }));

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
