#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 4) out;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float inner0;
    float inner1;
    float outer0;
    float outer1;
    float outer2;
    float outer3;
} sb_levels;

layout(location = 0) in  highp vec2 in_tc_position[];
layout(location = 0) out highp vec2 in_te_position[];

void main (void)
{
    in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];

    gl_TessLevelInner[0] = sb_levels.inner0;
    gl_TessLevelInner[1] = sb_levels.inner1;

    gl_TessLevelOuter[0] = sb_levels.outer0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
    gl_TessLevelOuter[2] = sb_levels.outer2;
    gl_TessLevelOuter[3] = sb_levels.outer3;
}
