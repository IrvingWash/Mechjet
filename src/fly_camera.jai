Fly_Camera :: struct {
    position: Vector3;

    front:    Vector3 = { 0, 0, -1 };
    up:       Vector3 = { 0, 1, 0 };
    right:    Vector3 = { 1, 0, 0 };
    world_up: Vector3 = { 0, 1, 0 };

    fov:  float = #run Engine.deg_to_rad(60);

    near: float = 0.1;
    far:  float = 1000;

    yaw:   float = #run Engine.deg_to_rad(-90);
    pitch: float = 0;

    speed: float = 2.5;

    sensitivity: float = 0.005;
    zoom_sensitivity: float = 0.05;

    z_near: float = 0.1;
    z_far:  float = 100;
}

look_at :: (camera: *Fly_Camera, target: Vector3) {
    direction := normalize(target - camera.position);

    camera.pitch = asin(direction.y);
    camera.yaw = atan2(direction.z, direction.x);
}

update_camera :: (camera: *Fly_Camera) {
    dt := Engine.get_delta_time();

    move_camera(camera, dt);
    zoom_camera(camera);
    turn_camera(camera);

    update_camera_vectors(camera);
}



#scope_file

MAX_FOV:  float : #run Engine.deg_to_rad(100);
MIN_FOV:  float : #run Engine.deg_to_rad(1);
MAX_PITCH: float : #run Engine.deg_to_rad(89);

turn_camera :: (camera: *Fly_Camera) {
    xy := Engine.get_cursor_delta();

    camera.yaw   += xy.x * camera.sensitivity;
    camera.pitch -= xy.y * camera.sensitivity;
    camera.pitch = clamp(
        camera.pitch,
        -MAX_PITCH,
        MAX_PITCH,
    );
}

zoom_camera :: (camera: *Fly_Camera) {
    offset := Engine.get_scroll_delta().y;

    camera.fov -= offset * camera.zoom_sensitivity;

    if camera.fov < MIN_FOV {
        camera.fov = MIN_FOV;
    } else if camera.fov > MAX_FOV {
        camera.fov = MAX_FOV;
    }
}

move_camera :: (using camera: *Fly_Camera, dt: float) {
    if Engine.is_key_held(.W) {
        position += front * speed * dt;
    }
    if Engine.is_key_held(.S) {
        position -= front * speed * dt;
    }
    if Engine.is_key_held(.A) {
        position -= right * speed * dt;
    }
    if Engine.is_key_held(.D) {
        position += right * speed * dt;
    }
    if Engine.is_key_held(.Q) {
        position -= up * speed * dt;
    }
    if Engine.is_key_held(.E) {
        position += up * speed * dt;
    }
}

update_camera_vectors :: (camera: *Fly_Camera) {
    camera.front.x = cos(camera.yaw) * cos(camera.pitch);
    camera.front.y = sin(camera.pitch);
    camera.front.z = sin(camera.yaw) * cos(camera.pitch);

    camera.front = normalize(camera.front);

    camera.right = normalize(cross(camera.front, camera.world_up));
    camera.up    = normalize(cross(camera.right, camera.front));
}


#scope_file

#import "Math";
Engine :: #import "Engine";
