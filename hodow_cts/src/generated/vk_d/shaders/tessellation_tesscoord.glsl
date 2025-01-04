#version 310 es

void main (void)
{
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 1) out;

layout(set = 0, binding = 0, std430) readonly restrict buffer TessLevels {
    float inner0;
    float inner1;
    float outer0;
    float outer1;
    float outer2;
    float outer3;
} sb_levels;

void main (void)
{
    gl_TessLevelInner[0] = sb_levels.inner0;
    gl_TessLevelInner[1] = sb_levels.inner1;

    gl_TessLevelOuter[0] = sb_levels.outer0;
    gl_TessLevelOuter[1] = sb_levels.outer1;
    gl_TessLevelOuter[2] = sb_levels.outer2;
    gl_TessLevelOuter[3] = sb_levels.outer3;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, equal_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, equal_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(triangles, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(triangles, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, equal_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, equal_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(quads, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(quads, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, equal_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, equal_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_odd_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(isolines, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.tessCoord[index] = gl_TessCoord;
    gl_PointSize = 1.0f;
}
