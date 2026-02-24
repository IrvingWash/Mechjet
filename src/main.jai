#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
Engine :: #import "Engine"()(DEBUG = DEBUG);

main :: () {
    defer report_memory_leaks();

    ok := Engine.init("Mechjet", 800, 600);
    assert(ok);
    defer Engine.deinit();

    while !Engine.should_quit() {
        Engine.begin_frame();

        Engine.start_drawing();
        Engine.end_drawing();
    }
    reset_temporary_storage();
}
