// @no_merge

struct VertexInput {
    @location(0) position: vec2f,
    @location(1) color:    vec3f,
}

struct VertexOutput {
    @builtin(position) position: vec4f,
    @location(0)       color:    vec4f,
}

@vertex
fn vs_main(input: VertexInput) -> VertexOutput {
    var output: VertexOutput;

    output.position = vec4f(input.position, 0, 1);
    output.color = vec4f(input.color, 1);

    return output;
}

@fragment
fn fs_main(input: VertexOutput) -> @location(0) vec4f {
    return input.color;
}
