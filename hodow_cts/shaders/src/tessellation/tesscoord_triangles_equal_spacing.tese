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
