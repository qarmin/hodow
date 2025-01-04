#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS ${one_minus}
#define NUM_COMPONENTS ${num_components}

layout(${layout_qualifiers}) in;

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    vec3 tessCoord[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numInvocations, 1);
#if ONE_MINUS == 0
    sb_out.tessCoord[index] = gl_TessCoord;
#else
    {
        float oneMinusComp        = 1.0 - gl_TessCoord.x;
        sb_out.tessCoord[index].x = gl_TessCoord.x + oneMinusComp;
    }
    {
        float oneMinusComp        = 1.0 - gl_TessCoord.y;
        sb_out.tessCoord[index].y = gl_TessCoord.y + oneMinusComp;
    }
#if NUM_COMPONENTS == 3
    {
        float oneMinusComp        = 1.0 - gl_TessCoord.z;
        sb_out.tessCoord[index].z = gl_TessCoord.z + oneMinusComp;
    }
#endif
#endif
    gl_PointSize = 1.0f;
}
