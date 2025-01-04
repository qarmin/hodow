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
