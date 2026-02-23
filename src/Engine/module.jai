#module_parameters()(DEBUG := false);

init :: (title: string, window_width: u32, window_height: u32) -> ok: bool {
    return true;
}

deinit :: () {
}



#scope_file

Engine :: struct {
}

engine: Engine;

#import "Basic";
