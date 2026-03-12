#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
#import "Math";
Engine :: #import "Engine"()(DEBUG = DEBUG);

#load "entity.jai";
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

    entities: [..]Entity;
    defer array_free(entities);

    _, lantern_model := Engine.get_model_handle("modules/GLTF/assets/lantern/lantern.gltf");
    array_add(*entities, Entity.{
        scale = { 0.2, 0.2, 0.2 },
        model = lantern_model,
    });

    _, mech_model := Engine.get_model_handle("modules/GLTF/assets/mech/mech.gltf");
    array_add(*entities, Entity.{
        position = { 1, 0, 1 },
        tint = { 0.7, 0.7, 0, 1 },
        model = mech_model,
    });

    _, mccree_model := Engine.get_model_handle("modules/GLTF/assets/mccree/scene.gltf");
    array_add(*entities, Entity.{
        position = { -5, 0, 5 },
        model = mccree_model,
    });

    GRID_SIZE :: 10;
    HALF_GRID_SIZE :: 10 / 2;
    _, cube_model := Engine.get_model_handle("assets/models/cube/cube.gltf");
    for x: -HALF_GRID_SIZE..HALF_GRID_SIZE {
        for y: -HALF_GRID_SIZE..HALF_GRID_SIZE {
            array_add(
                *entities,
                {
                    model = cube_model,
                    position = { xx x, -0.5, xx y },
                },
            );
        }
    }

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

        for entity: entities {
            Engine.draw_model(
                Engine.resolve_model_handle(entity.model),
                get_model_transform(entity),
                entity.tint,
            );
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
