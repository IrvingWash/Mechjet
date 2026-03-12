Entity :: struct {
    position: Vector3;
    scale:    Vector3 = { 1, 1, 1 };
    rotation: Quaternion;

    model: Engine.Model_Handle;
    tint:  Vector4 = { 1, 1, 1, 1 };
}

get_model_transform :: (entity: Entity) -> Matrix4 {
    return make_translation_matrix4(entity.position)
        * rotation_matrix(Matrix4, entity.rotation)
        * make_scale_matrix4(entity.scale);
}



#scope_file

#import "Math";
Engine :: #import "Engine";
