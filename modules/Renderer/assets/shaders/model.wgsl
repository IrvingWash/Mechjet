struct Transforms {
    projection: mat4x4f,
    view:       mat4x4f,
}

struct VertexInput {
    @location(0) position: vec3f,
    @location(1) normal:   vec3f,
    @location(2) uv:       vec2f,
}

struct InstanceInput {
    // Column-major matrix
    @location(3) transform_column_1: vec4f,
    @location(4) transform_column_2: vec4f,
    @location(5) transform_column_3: vec4f,
    @location(6) transform_column_4: vec4f,

    // Column-major matrix
    @location(7) normal_column_1: vec3f,
    @location(8) normal_column_2: vec3f,
    @location(9) normal_column_3: vec3f,

    @location(10) tint: vec4f,
}

struct VertexOutput {
    @builtin(position) clip_position: vec4f,
    @location(0)       normal:        vec3f,
    @location(1)       uv:            vec2f,
    @location(2)       tint:          vec4f,
}

@group(0) @binding(0)
var<uniform> u_transforms: Transforms;

@vertex
fn vs_main(vertex_input: VertexInput, instance_input: InstanceInput) -> VertexOutput {
    let model_transform = mat4x4f(
        instance_input.transform_column_1,
        instance_input.transform_column_2,
        instance_input.transform_column_3,
        instance_input.transform_column_4,
    );

    let normal_transform = mat3x3f(
        instance_input.normal_column_1,
        instance_input.normal_column_2,
        instance_input.normal_column_3,
    );

    var output: VertexOutput;

    output.clip_position = u_transforms.projection
        * u_transforms.view
        * model_transform
        * vec4f(vertex_input.position, 1);

    output.normal = normal_transform * vertex_input.normal;

    output.uv     = vertex_input.uv;

    output.tint   = instance_input.tint;

    return output;
}



struct MaterialParams {
    base_color_factor: vec4f,
}

@group(1) @binding(0)
var<uniform> u_material_params: MaterialParams;
@group(1) @binding(1)
var base_color_texture: texture_2d<f32>;
@group(1) @binding(2)
var base_color_sampler: sampler;

@fragment
fn fs_main(input: VertexOutput) -> @location(0) vec4f {
    return textureSample(
        base_color_texture,
        base_color_sampler,
        input.uv,
    ) * u_material_params.base_color_factor * input.tint;
}
