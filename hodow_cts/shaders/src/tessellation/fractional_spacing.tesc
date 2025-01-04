#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float outer1;
} sb_levels;

void main (void)
{
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
}
