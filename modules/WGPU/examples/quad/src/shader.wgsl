@group(0) @binding(0) var<uniform> uTime: f32;

struct VertexInput {
    @location(0) position: vec2f,
    @location(1) color: vec3f,
}

struct VertexOutput {
    @builtin(position) position: vec4f,
    @location(0) color: vec3f,
}

@vertex
fn vs_main(input: VertexInput) -> VertexOutput {
    var output: VertexOutput;

    output.color = input.color;

    var offset = 0.3 * vec2f(cos(uTime), sin(uTime));

    output.position = vec4f(input.position + offset, 0, 1);

    return output;
}

@fragment
fn fs_main(input: VertexOutput) -> @location(0) vec4f {
    let linear_color = pow(input.color, vec3f(2.2));

    return vec4f(linear_color, 1);
}
