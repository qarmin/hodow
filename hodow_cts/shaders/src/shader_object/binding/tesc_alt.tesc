#version 450

layout(vertices = 4) out;
#if ${unused} == 2
layout (location = 0) out vec4 color[];
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
    vec4 pos = gl_in[gl_InvocationID].gl_Position;
    pos.xy *= 0.5f;
    gl_out[gl_InvocationID].gl_Position = pos;
#if ${unused} == 2
    color[gl_InvocationID] = vec4(1.0f);
#endif
}
