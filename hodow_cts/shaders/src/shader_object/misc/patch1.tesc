#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=4) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
layout (push_constant, std430) uniform PCBlock { vec4 color; } pc;
layout (location=0) patch out vec4 foo;
layout (location=1) patch out vec4 patchColor;
layout (location=2) patch out vec4 bar;
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
    foo        = pc.color.bgra;
    patchColor = pc.color;
    bar        = pc.color.gbra;
}
