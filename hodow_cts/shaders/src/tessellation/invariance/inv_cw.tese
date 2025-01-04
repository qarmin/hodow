#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE ${prim_id}
#define MIRROR ${mirror}

layout(${prim}, ${spacing}, cw) in;

layout(location = 0) out VertexData {
    vec4 in_gs_tessCoord;
    int  in_gs_primitiveID;
} ib_out;

void main (void)
{
#if MIRROR == 0
    ib_out.in_gs_tessCoord   = vec4(gl_TessCoord, 0.0);
#elif PRIMITIVE == 0
    float x = gl_TessCoord.x;
    float y = gl_TessCoord.y;
    float z = gl_TessCoord.z;

    // Mirror one half of each outer edge onto the other half, except the endpoints (because they belong to two edges)
    ib_out.in_gs_tessCoord   = z == 0.0 && x > 0.5 && x != 1.0 ? vec4(1.0-x,  1.0-y,    0.0, 1.0)
                             : y == 0.0 && z > 0.5 && z != 1.0 ? vec4(1.0-x,    0.0,  1.0-z, 1.0)
                             : x == 0.0 && y > 0.5 && y != 1.0 ? vec4(  0.0,  1.0-y,  1.0-z, 1.0)
                             : vec4(x, y, z, 0.0);
#elif PRIMITIVE == 1
    float x = gl_TessCoord.x;
    float y = gl_TessCoord.y;

    // Mirror one half of each outer edge onto the other half, except the endpoints (because they belong to two edges)
    ib_out.in_gs_tessCoord   = (x == 0.0 || x == 1.0) && y > 0.5 && y != 1.0 ? vec4(    x, 1.0-y, 0.0, 1.0)
                             : (y == 0.0 || y == 1.0) && x > 0.5 && x != 1.0 ? vec4(1.0-x,     y, 0.0, 1.0)
                             : vec4(x, y, 0.0, 0.0);
#else
    float x = gl_TessCoord.x;
    float y = gl_TessCoord.y;

    // Mirror one half of each outer edge onto the other half
    ib_out.in_gs_tessCoord   = (x == 0.0 || x == 1.0) && y > 0.5 ? vec4(x, 1.0-y, 0.0, 1.0)
                             : vec4(x, y, 0.0, 0.0);
#endif
    ib_out.in_gs_primitiveID = gl_PrimitiveID;
}
