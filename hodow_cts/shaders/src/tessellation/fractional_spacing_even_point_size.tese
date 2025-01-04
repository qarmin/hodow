#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

layout(isolines, fractional_even_spacing, point_mode) in;

layout(set = 0, binding = 1, std430) restrict buffer Results {
    float data[];
} sb_out_tessCoord;
layout(set = 0, binding = 2, std430) coherent restrict buffer Counter {
    int   data;
} sb_out_numInvocations;

void main (void)
{
    int index = atomicAdd(sb_out_numInvocations.data, 1);
    sb_out_tessCoord.data[index] = gl_TessCoord.x;
    gl_PointSize = 1.0f;
}
