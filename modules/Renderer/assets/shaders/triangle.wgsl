// @no_merge

struct VertexInput {
    @location(0) position: vec3f,
    @location(1) normal:   vec3f,
    @location(2) uv:       vec2f,
}

struct VertexOutput {
    @builtin(position) world_position: vec4f,
    @location(0)       normal:         vec3f,
    @location(1)       uv:             vec2f,
}

@vertex
fn vs_main(input: VertexInput) -> VertexOutput {
    var output: VertexOutput;

    output.world_position = vec4f(input.position, 1);
    output.normal   = input.normal;
    output.uv = input.uv;

    return output;
}

@fragment
fn fs_main(input: VertexOutput) -> @location(0) vec4f {
    return vec4f(1, 0, 0, 1);
}
