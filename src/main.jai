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

    ok := Engine.init("Mechjet", 800, 600);
    assert(ok);
    defer Engine.deinit();

    while !Engine.should_quit() {
        Engine.begin_frame();

        Engine.start_drawing(
            Camera.{
                position = { 0, 0, 1 },
                fov_radians = Engine.deg_to_rad(60),
                z_near = 0.1,
                z_far = 100,
            },
        );

        Engine.end_drawing();

        reset_temporary_storage();
    }
}
