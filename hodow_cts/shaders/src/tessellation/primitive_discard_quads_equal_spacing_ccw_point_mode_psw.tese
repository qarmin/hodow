#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, equal_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    gl_PointSize = 1.0;
}
