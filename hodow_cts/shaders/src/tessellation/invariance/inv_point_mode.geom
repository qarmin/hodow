#version 310 es
#extension GL_EXT_geometry_shader : require


#define NV 1

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0) in VertexData {
    vec4 in_gs_tessCoord;
    int  in_gs_primitiveID;
} ib_in[];

struct PerPrimitive {
    int  patchPrimitiveID;
    int  primitiveID;
    vec4 tessCoord[3];
};

layout(set = 0, binding = 0, std430) coherent restrict buffer Output {
    int          numPrimitives;
    PerPrimitive primitive[];
} sb_out;

void main (void)
{
    int index = atomicAdd(sb_out.numPrimitives, 1);
    sb_out.primitive[index].patchPrimitiveID = ib_in[0].in_gs_primitiveID;
    sb_out.primitive[index].primitiveID      = index;
    sb_out.primitive[index].tessCoord[0]     = ib_in[0].in_gs_tessCoord;
#if NV >= 2
    sb_out.primitive[index].tessCoord[1]     = ib_in[1].in_gs_tessCoord;
#endif
#if NV >= 3
    sb_out.primitive[index].tessCoord[2]     = ib_in[2].in_gs_tessCoord;
#endif

    gl_Position = vec4(0.0);

    EmitVertex();
#if NV >= 2

    gl_Position = vec4(0.0);

    EmitVertex();
#endif
#if NV >= 3

    gl_Position = vec4(0.0);

    EmitVertex();
#endif
}
