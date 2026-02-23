#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER = DEBUG,
    TEMP_ALLOCATOR_POISON_FREED_MEMORY = DEBUG,
    ENABLE_ASSERT = DEBUG,
);
Engine :: #import,dir "Engine"()(DEBUG = DEBUG);

main :: () {
    defer report_memory_leaks();

    Engine.init("Mechjet", 800, 600);
    defer Engine.deinit();

    reset_temporary_storage();
}
