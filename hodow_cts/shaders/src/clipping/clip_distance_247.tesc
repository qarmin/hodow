#version 450

layout(vertices = 3) out;

layout(location = 0) in  vec4 in_color[];
layout(location = 0) out vec4 out_color[];

in gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_in[gl_MaxPatchVertices];

out gl_PerVertex {
    vec4  gl_Position;
    float gl_ClipDistance[4];
    float gl_CullDistance[4];
} gl_out[];

void main (void)
{
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;

    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;

    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    out_color[gl_InvocationID]          = in_color[gl_InvocationID];

    for (int i = 0; i < 4; ++i)
        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];
    for (int i = 0; i < 4; ++i)
    {
        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? 0.3f : 0.2f;
    }
}
