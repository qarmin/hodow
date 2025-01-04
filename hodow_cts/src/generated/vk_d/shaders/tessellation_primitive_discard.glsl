#version 310 es

layout(location = 0) in  highp float in_v_attr;
layout(location = 0) out highp float in_tc_attr;

void main (void)
{
    in_tc_attr = in_v_attr;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(location = 0) in highp float in_tc_attr[];

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;

void main (void)
{
    in_te_positionScale  = vec2(in_tc_attr[6], in_tc_attr[7]);
    in_te_positionOffset = vec2(in_tc_attr[8], in_tc_attr[9]);

    gl_TessLevelInner[0] = in_tc_attr[0];
    gl_TessLevelInner[1] = in_tc_attr[1];

    gl_TessLevelOuter[0] = in_tc_attr[2];
    gl_TessLevelOuter[1] = in_tc_attr[3];
    gl_TessLevelOuter[2] = in_tc_attr[4];
    gl_TessLevelOuter[3] = in_tc_attr[5];
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es

layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = vec4(1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

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
}
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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, equal_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, equal_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, equal_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, equal_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing, ccw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing, cw) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing, cw, point_mode) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
} sb_out;

void main (void)
{
    atomicAdd(sb_out.numInvocations, 1);

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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
