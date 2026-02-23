#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
Engine :: #import,dir "Engine"()(DEBUG = DEBUG);

main :: () {
    defer report_memory_leaks();

    ok := Engine.init("Mechjet", 800, 600);
    assert(ok);
    defer Engine.deinit();

    while !Engine.should_quit() {
        Engine.begin_frame();
    }
    reset_temporary_storage();
}
