#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
#import "Math";
Engine :: #import "Engine"()(DEBUG = DEBUG);

#load "fly_camera.jai";

main :: () {
    #if DEBUG {
        defer report_memory_leaks();
    }

    setup_formatting();

    ok := Engine.init("Mechjet", 800, 600, { 0, 0, 0, 1 });
    assert(ok);
    defer Engine.deinit();

    fly_camera: Fly_Camera = {
        position = {
            x = -1.4,
            y = 3.8,
            z = 14,
        },
    };

    ok =, lantern_handle := Engine.get_model_handle("modules/GLTF/assets/lantern/lantern.gltf");
    assert(ok);
    ok =, mccree_handle := Engine.get_model_handle("modules/GLTF/assets/mccree/scene.gltf");
    assert(ok);
    ok =, mech_handle := Engine.get_model_handle("modules/GLTF/assets/mech/mech.gltf");
    assert(ok);
    ok =, cube_handle := Engine.get_model_handle("assets/models/cube/cube.gltf");
    assert(ok);

    Engine.set_ambient_light({ color = { 0.01, 0.01, 0.1 }});
    Engine.set_directional_light({
        color = { 0.1, 0.1, 0.5 },
        direction = { -1, -1, -1 },
    });

    while !Engine.should_quit() {
        Engine.begin_frame();

        update_camera(*fly_camera);

        Engine.start_drawing({
            position    = fly_camera.position,
            target      = fly_camera.position + fly_camera.front,
            up          = fly_camera.up,
            fov_radians = fly_camera.fov,
            z_near = 0.1,
            z_far  = 1000,
        });

        Engine.draw_model(Engine.resolve_model_handle(lantern_handle), make_scale_matrix4({ 0.2, 0.2, 0.2 }), { 1, 1, 1, 1 });
        Engine.draw_model(Engine.resolve_model_handle(mccree_handle), make_translation_matrix4({ -5, 0, 5 }) * make_scale_matrix4({ 1, 1, 1 }), { 1, 1, 1, 1 });
        Engine.draw_model(Engine.resolve_model_handle(mech_handle), make_translation_matrix4({ 1, 0, 1 }), { 1, 1, 1, 1 });
        for x: -5..5 {
            for y: -5..5 {
                Engine.draw_model(
                    Engine.resolve_model_handle(cube_handle),
                    make_translation_matrix4({ xx x, -0.5, xx y }),
                    { 1, 1, 1, 1 },
                );
            }
        }

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
