#version 450

layout (vertices = 3) out;

layout (location = 1) in vec4 vColor[];
layout (location = 2) out vec4 tcColor[];

void main()
{
    tcColor[gl_InvocationID] = vColor[gl_InvocationID];
    tcColor[gl_InvocationID].r = float(gl_PatchVerticesIn) / 3;

    if (gl_InvocationID == 0) {
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelInner[0] = 1.0;
    }

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_CullDistance[0] = gl_in[gl_InvocationID].gl_CullDistance[0];
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
