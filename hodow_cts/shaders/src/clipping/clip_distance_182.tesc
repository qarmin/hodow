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

    gl_out[gl_InvocationID].gl_ClipDistance[0] = gl_in[gl_InvocationID].gl_ClipDistance[0];
    gl_out[gl_InvocationID].gl_ClipDistance[1] = gl_in[gl_InvocationID].gl_ClipDistance[1];
    gl_out[gl_InvocationID].gl_ClipDistance[2] = gl_in[gl_InvocationID].gl_ClipDistance[2];
    gl_out[gl_InvocationID].gl_ClipDistance[3] = gl_in[gl_InvocationID].gl_ClipDistance[3];
    gl_out[gl_InvocationID].gl_CullDistance[0] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[1] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[2] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
    gl_out[gl_InvocationID].gl_CullDistance[3] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;
}
