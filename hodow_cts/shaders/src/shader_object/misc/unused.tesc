#version 450

layout(vertices = 4) out;
#if ${stage} == 2 && ${builtin} == 0
layout(location = 0) out vec4 unused[];
#endif

void main (void)
{
    if (gl_InvocationID == 0) {
        gl_TessLevelInner[0] = 1.0;
        gl_TessLevelInner[1] = 1.0;
        gl_TessLevelOuter[0] = 1.0;
        gl_TessLevelOuter[1] = 1.0;
        gl_TessLevelOuter[2] = 1.0;
        gl_TessLevelOuter[3] = 1.0;
    }
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
#if ${stage} == 2
#if ${builtin} == 1
    gl_out[gl_InvocationID].gl_PointSize = 16.0f;
    gl_out[gl_InvocationID].gl_ClipDistance[0] = 2.0f;
#else
    unused[gl_InvocationID] = vec4(1.0f);
#endif
#endif
}
