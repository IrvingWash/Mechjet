#scope_module

Time_State_Handle :: #type *void;

init_time :: () -> Time_State_Handle {
    time_state := New(Time_State);

    return time_state;
}

deinit_time :: (handle: Time_State_Handle) {
    time_state := cast(*Time_State, handle);

    free(time_state);
}

update_time :: (handle: Time_State_Handle) {
    time_state := cast(*Time_State, handle);

    time_state.raw.previous = time_state.raw.current;
    time_state.raw.current  = seconds_since_init();
    time_state.raw.delta = min(time_state.raw.current - time_state.raw.previous, MAX_DELTA_TIME);
}

get_delta_time :: (handle: Time_State_Handle) -> float {
    time_state := cast(*Time_State, handle);

    // @Todo @Incomplete we need world time vs raw time

    return cast(float, time_state.raw.delta);
}



#scope_file

// @Todo the value is hardcoded
MAX_DELTA_TIME: float64 : 1.0 / 60.0 * 2.0;

Time_State :: struct {
    raw: Raw_Time;
}

Raw_Time :: struct {
    previous: float64;
    current:  float64;
    delta:    float64;
}

#import "Basic";
