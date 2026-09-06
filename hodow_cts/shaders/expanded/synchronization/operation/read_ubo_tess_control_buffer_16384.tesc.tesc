#version 440

layout(vertices = 3) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4 gl_Position;
} gl_out[];

layout(set = 0, binding = 0, std140) readonly uniform Input {
    uvec4 data[1024];
} b_in;

layout(set = 0, binding = 1, std140) writeonly buffer Output {
    uvec4 data[1024];
} b_out;

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    for (int i = 0; i < 1024; ++i) {
        b_out.data[i] = b_in.data[i];
    }
}
