/*
API

```
create_converter :: () -> *GLTF_Converter;

destroy_converter :: (converter: *GLTF_Converter);

load_scene :: (gltf_path: string) -> error: string, Scene;

release_scene :: (scene: *Scene);
```
*/

#module_parameters(DO_SANITY_CHECKS: bool = false);

#load "src/scene.jai";
#load "src/gltf_converter.jai";



#scope_module

ABSENT: s32 : -1;
