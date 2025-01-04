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

void main (void)
{
    gl_TessLevelInner[0] = in_tc_attr[0];
    gl_TessLevelInner[1] = in_tc_attr[1];

    gl_TessLevelOuter[0] = in_tc_attr[2];
    gl_TessLevelOuter[1] = in_tc_attr[3];
    gl_TessLevelOuter[2] = in_tc_attr[4];
    gl_TessLevelOuter[3] = in_tc_attr[5];
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_geometry_shader : require


#define NV 3

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

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
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require

#define NV 3

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

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
    gl_PointSize = 1.0f;
    EmitVertex();
#if NV >= 2

    gl_Position = vec4(0.0);
    gl_PointSize = 1.0f;
    EmitVertex();
#endif
#if NV >= 3

    gl_Position = vec4(0.0);
    gl_PointSize = 1.0f;
    EmitVertex();
#endif
}
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
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require

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
    gl_PointSize = 1.0f;
    EmitVertex();
#if NV >= 2

    gl_Position = vec4(0.0);
    gl_PointSize = 1.0f;
    EmitVertex();
#endif
#if NV >= 3

    gl_Position = vec4(0.0);
    gl_PointSize = 1.0f;
    EmitVertex();
#endif
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 0

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 0

layout(quads, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_geometry_shader : require


#define NV 2

layout(lines) in;
layout(line_strip, max_vertices = 2) out;

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
#version 310 es
#extension GL_EXT_geometry_shader : require
#extension GL_EXT_geometry_point_size : require

#define NV 2

layout(lines) in;
layout(line_strip, max_vertices = 2) out;

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
    gl_PointSize = 1.0f;
    EmitVertex();
#if NV >= 2

    gl_Position = vec4(0.0);
    gl_PointSize = 1.0f;
    EmitVertex();
#endif
#if NV >= 3

    gl_Position = vec4(0.0);
    gl_PointSize = 1.0f;
    EmitVertex();
#endif
}
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 0

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 0
#define MIRROR 1

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 1
#define MIRROR 1

layout(quads, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require

#define PRIMITIVE 2
#define MIRROR 1

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 0
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 3

layout(triangles, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(quads, fractional_even_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, equal_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_odd_spacing, cw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, ccw, point_mode) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw) in;

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
#version 310 es
#extension GL_EXT_tessellation_shader : require


#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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

}
#version 310 es
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_tessellation_point_size : require

#define ONE_MINUS 1
#define NUM_COMPONENTS 2

layout(isolines, fractional_even_spacing, cw, point_mode) in;

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
