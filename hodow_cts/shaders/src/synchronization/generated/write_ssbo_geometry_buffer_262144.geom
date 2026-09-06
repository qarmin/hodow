#version 440

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

layout(set = 0, binding = 0, std140) readonly buffer Input {
    uvec4 data[16384];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[16384];
} b_out;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    EmitVertex();

    gl_Position = gl_in[1].gl_Position;
    EmitVertex();

    gl_Position = gl_in[2].gl_Position;
    EmitVertex();

    for (int i = 0; i < 16384; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
