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
    @location(3) transform_column_1: vec4f,
    @location(4) transform_column_2: vec4f,
    @location(5) transform_column_3: vec4f,
    @location(6) transform_column_4: vec4f,
}

struct VertexOutput {
    @builtin(position) world_position: vec4f,
    @location(0)       normal:         vec3f,
    @location(1)       uv:             vec2f,
}

@group(0) @binding(0)
var<uniform> uTransforms: Transforms;

@vertex
fn vs_main(vertex_input: VertexInput, instance_input: InstanceInput) -> VertexOutput {
    var output: VertexOutput;

    let model_transform = mat4x4f(
        instance_input.transform_column_1,
        instance_input.transform_column_2,
        instance_input.transform_column_3,
        instance_input.transform_column_4,
    );

    output.world_position = uTransforms.projection * uTransforms.view * model_transform * vec4f(vertex_input.position, 1);
    output.normal   = vertex_input.normal;
    output.uv = vertex_input.uv;

    return output;
}

@fragment
fn fs_main(input: VertexOutput) -> @location(0) vec4f {
    return vec4f(1, 0, 0, 1);
}
