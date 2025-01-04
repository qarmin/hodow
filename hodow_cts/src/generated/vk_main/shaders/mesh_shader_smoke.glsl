#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=8, local_size_y=4, local_size_z=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (set=0, binding=0) uniform CoordsBuffer {
    vec4 coords[3];
} cb;
layout (set=0, binding=1, std430) readonly buffer IndexBuffer {
    uint indices[3];
} ib;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

void main ()
{
    SetMeshOutputsEXT(3u, 1u);
    triangleColor[0] = vec4(0.0, 0.0, 1.0, 1.0);

    const uint vertexIndex = gl_LocalInvocationIndex;
    if (vertexIndex < 3u)
    {
        const uint coordsIndex = ib.indices[vertexIndex];
        gl_MeshVerticesEXT[vertexIndex].gl_Position = cb.coords[coordsIndex];
    }
    if (vertexIndex == 0u)
    {
        gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT vec4 triangleColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = triangleColor;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=8, local_size_y=4, local_size_z=4) in;

struct TaskData {
    uint triangleIndex;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        td.triangleIndex = gl_WorkGroupID.x;
    }
    EmitMeshTasksEXT(1u, 1u, 1u);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=8, local_size_y=4, local_size_z=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (set=0, binding=0) uniform CoordsBuffer {
    vec4 coords[4];
} cb;
layout (set=0, binding=1, std430) readonly buffer IndexBuffer {
    uint indices[6];
} ib;

layout (location=0) out perprimitiveEXT vec4 triangleColor[];

struct TaskData {
    uint triangleIndex;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    SetMeshOutputsEXT(3u, 1u);

    const uint triangleVertex = gl_LocalInvocationIndex;
    const uint indexArrayPos  = td.triangleIndex * 3u + triangleVertex;

    if (triangleVertex < 3u)
    {
        const uint coordsIndex = ib.indices[indexArrayPos];
        gl_MeshVerticesEXT[triangleVertex].gl_Position = cb.coords[coordsIndex];
    }
    if (triangleVertex == 0u)
    {
        gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
        triangleColor[0] = vec4(0.0, 0.0, 1.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=1) in;

void main ()
{
    EmitMeshTasksEXT(0u, 0u, 0u);
}
#version 450

layout (location=0) in  vec4 inColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = inColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout(local_size_x=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out vec4 outColor[];

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    const uint vertex    = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;

    const vec4 topLeft      = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 botLeft      = vec4(-1.0,  1.0, 0.0, 1.0);
    const vec4 topRight     = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 botRight     = vec4( 1.0,  1.0, 0.0, 1.0);
    const vec4 positions[4] = vec4[](topLeft, botLeft, topRight, botRight);

    const float width      = 256;
    const float height     = 256;
    const float halfWidth  = (1.0 / (width - 1.0)) / 2.0;
    const float halfHeight = (1.0 / (height - 1.0)) / 2.0;
    const float minGreen   = -halfWidth;
    const float maxGreen   = 1.0+halfWidth;
    const float minBlue    = -halfHeight;
    const float maxBlue    = 1.0+halfHeight;
    const vec4  colors[4]  = vec4[](
        vec4(0, minGreen, minBlue, 1.0),
        vec4(0, minGreen, maxBlue, 1.0),
        vec4(0, maxGreen, minBlue, 1.0),
        vec4(0, maxGreen, maxBlue, 1.0)
    );

    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(1, 3, 2)
    );
    if (vertex < 4u)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = positions[vertex];
        outColor[vertex] = colors[vertex];
    }
    if (primitive < 2u)
    {
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout(local_size_x=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out vec4 outColor[];

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    const uint vertex    = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;

    const vec4 topLeft      = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 botLeft      = vec4(-1.0,  1.0, 0.0, 1.0);
    const vec4 topRight     = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 botRight     = vec4( 1.0,  1.0, 0.0, 1.0);
    const vec4 positions[4] = vec4[](topLeft, botLeft, topRight, botRight);

    const float width      = 256;
    const float height     = 256;
    const float halfWidth  = (1.0 / (width - 1.0)) / 2.0;
    const float halfHeight = (1.0 / (height - 1.0)) / 2.0;
    const float minGreen   = -halfWidth;
    const float maxGreen   = 1.0+halfWidth;
    const float minBlue    = -halfHeight;
    const float maxBlue    = 1.0+halfHeight;
    const vec4  colors[4]  = vec4[](
        vec4(0, minGreen, minBlue, 1.0),
        vec4(0, minGreen, maxBlue, 1.0),
        vec4(0, maxGreen, minBlue, 1.0),
        vec4(0, maxGreen, maxBlue, 1.0)
    );

    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(1, 3, 2)
    );
    if (vertex < 4u)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = positions[vertex];
        outColor[vertex] = colors[vertex];
    }
    if (primitive < 2u)
    {
        gl_MeshPrimitivesEXT[primitive].gl_PrimitiveShadingRateEXT = (gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT);
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_fragment_shading_rate : enable

layout(local_size_x=4) in;
layout(triangles) out;
layout(max_vertices=256, max_primitives=256) out;

layout (location=0) out vec4 outColor[];

perprimitiveEXT out gl_MeshPerPrimitiveEXT {
   int gl_PrimitiveShadingRateEXT;
} gl_MeshPrimitivesEXT[];

void main ()
{
    SetMeshOutputsEXT(4u, 2u);

    const uint vertex    = gl_LocalInvocationIndex;
    const uint primitive = gl_LocalInvocationIndex;

    const vec4 topLeft      = vec4(-1.0, -1.0, 0.0, 1.0);
    const vec4 botLeft      = vec4(-1.0,  1.0, 0.0, 1.0);
    const vec4 topRight     = vec4( 1.0, -1.0, 0.0, 1.0);
    const vec4 botRight     = vec4( 1.0,  1.0, 0.0, 1.0);
    const vec4 positions[4] = vec4[](topLeft, botLeft, topRight, botRight);

    const float width      = 256;
    const float height     = 256;
    const float halfWidth  = (1.0 / (width - 1.0)) / 2.0;
    const float halfHeight = (1.0 / (height - 1.0)) / 2.0;
    const float minGreen   = -halfWidth;
    const float maxGreen   = 1.0+halfWidth;
    const float minBlue    = -halfHeight;
    const float maxBlue    = 1.0+halfHeight;
    const vec4  colors[4]  = vec4[](
        vec4(0, minGreen, minBlue, 1.0),
        vec4(0, minGreen, maxBlue, 1.0),
        vec4(0, maxGreen, minBlue, 1.0),
        vec4(0, maxGreen, maxBlue, 1.0)
    );

    const uvec3 indices[2] = uvec3[](
        uvec3(0, 1, 2),
        uvec3(1, 3, 2)
    );
    if (vertex < 4u)
    {
        gl_MeshVerticesEXT[vertex].gl_Position = positions[vertex];
        outColor[vertex] = colors[vertex];
    }
    if (primitive < 2u)
    {
        gl_MeshPrimitivesEXT[primitive].gl_PrimitiveShadingRateEXT = gl_ShadingRateFlag2HorizontalPixelsEXT;
        gl_PrimitiveTriangleIndicesEXT[primitive] = indices[primitive];
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

void main ()
{
    EmitMeshTasksEXT(2, 1u, 1u);
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) perprimitiveEXT in vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=192, max_primitives=64) out;

layout (location=0) perprimitiveEXT out vec4 primitiveColor[];

layout (set=0, binding=0, std430) readonly buffer VerticesBlock {
    vec2 coords[];
} vertex;

struct IndexAndColor {
    uint  index;
    float color;
};

layout (set=0, binding=1, std430) readonly buffer PrimitiveDataBlock {
    IndexAndColor data[];
} primitive;

layout (push_constant, std430) uniform PushConstantBlock {
    uint  totalTriangles;
    float depth;
    float red;
} pc;

void main ()
{
    const uint firstPrimitive   = gl_WorkGroupID.x * gl_WorkGroupSize.x;
    const uint wgTriangleCount  = ((pc.totalTriangles >= firstPrimitive) ? min(pc.totalTriangles - firstPrimitive, 64) : 0u);
    const uint wgVertexCount    = wgTriangleCount * 3u + 0u;

    SetMeshOutputsEXT(wgVertexCount, wgTriangleCount);

    if (gl_LocalInvocationIndex < wgTriangleCount) {
        const uint  primitiveID         = firstPrimitive + gl_LocalInvocationIndex;
        const uint  primitiveIndex      = primitive.data[primitiveID].index;
        const float blue                = primitive.data[primitiveID].color;
        const uint  firstVertexIndex    = primitiveIndex * 3u;
        const uvec3 globalVertexIndices = uvec3(firstVertexIndex, firstVertexIndex+1u, firstVertexIndex+2u);
        const uint  localPrimitiveID    = gl_LocalInvocationIndex;
        const uint  firstLocalVertex    = localPrimitiveID * 3u + 0u;
        const uvec3 localVertexIndices  = uvec3(firstLocalVertex, firstLocalVertex+1u, firstLocalVertex+2u);

        gl_MeshVerticesEXT[localVertexIndices.x].gl_Position = vec4(vertex.coords[globalVertexIndices.x], pc.depth, 1.0);
        gl_MeshVerticesEXT[localVertexIndices.y].gl_Position = vec4(vertex.coords[globalVertexIndices.y], pc.depth, 1.0);
        gl_MeshVerticesEXT[localVertexIndices.z].gl_Position = vec4(vertex.coords[globalVertexIndices.z], pc.depth, 1.0);

        gl_PrimitiveTriangleIndicesEXT[localPrimitiveID] = localVertexIndices;
        primitiveColor[localPrimitiveID]                 = vec4(pc.red, 0.0, blue, 1.0f);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (triangles) out;
layout (max_vertices=256, max_primitives=64) out;

layout (location=0) perprimitiveEXT out vec4 primitiveColor[];

layout (set=0, binding=0, std430) readonly buffer VerticesBlock {
    vec2 coords[];
} vertex;

struct IndexAndColor {
    uint  index;
    float color;
};

layout (set=0, binding=1, std430) readonly buffer PrimitiveDataBlock {
    IndexAndColor data[];
} primitive;

layout (push_constant, std430) uniform PushConstantBlock {
    uint  totalTriangles;
    float depth;
    float red;
} pc;

void main ()
{
    const uint firstPrimitive   = gl_WorkGroupID.x * gl_WorkGroupSize.x;
    const uint wgTriangleCount  = ((pc.totalTriangles >= firstPrimitive) ? min(pc.totalTriangles - firstPrimitive, 64) : 0u);
    const uint wgVertexCount    = wgTriangleCount * 3u + 64u;

    {
        const float proportion = float(gl_LocalInvocationIndex) / float(gl_WorkGroupSize.x);
        gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(proportion, 1.0 - proportion, pc.depth, 1.0);
    }

    SetMeshOutputsEXT(wgVertexCount, wgTriangleCount);

    if (gl_LocalInvocationIndex < wgTriangleCount) {
        const uint  primitiveID         = firstPrimitive + gl_LocalInvocationIndex;
        const uint  primitiveIndex      = primitive.data[primitiveID].index;
        const float blue                = primitive.data[primitiveID].color;
        const uint  firstVertexIndex    = primitiveIndex * 3u;
        const uvec3 globalVertexIndices = uvec3(firstVertexIndex, firstVertexIndex+1u, firstVertexIndex+2u);
        const uint  localPrimitiveID    = gl_LocalInvocationIndex;
        const uint  firstLocalVertex    = localPrimitiveID * 3u + 64u;
        const uvec3 localVertexIndices  = uvec3(firstLocalVertex, firstLocalVertex+1u, firstLocalVertex+2u);

        gl_MeshVerticesEXT[localVertexIndices.x].gl_Position = vec4(vertex.coords[globalVertexIndices.x], pc.depth, 1.0);
        gl_MeshVerticesEXT[localVertexIndices.y].gl_Position = vec4(vertex.coords[globalVertexIndices.y], pc.depth, 1.0);
        gl_MeshVerticesEXT[localVertexIndices.z].gl_Position = vec4(vertex.coords[globalVertexIndices.z], pc.depth, 1.0);

        gl_PrimitiveTriangleIndicesEXT[localPrimitiveID] = localVertexIndices;
        primitiveColor[localPrimitiveID]                 = vec4(pc.red, 0.0, blue, 1.0f);
    }
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (points) out;
layout (max_vertices=64, max_primitives=64) out;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) readonly buffer PositionsArray { vec4 position[]; } vtxData;
void main (void) {
    const uint primitiveVertices = 1;
    const uint row = gl_WorkGroupID.x;
    const uint col = gl_LocalInvocationIndex;
    const uint pixelIdx = row * 64 + col;
    const uint baseInVertex = pixelIdx * primitiveVertices;
    const uint baseOutVertex = col * primitiveVertices;
    SetMeshOutputsEXT(64, 64);
    for (uint i = 0u; i < primitiveVertices; ++i) {
        const uint inIndex = baseInVertex + i;
        const uint outIndex = baseOutVertex + i;
        vec4 outPos;
        outPos.x = vtxData.position[inIndex].x - 1000.0;
        outPos.y = vtxData.position[inIndex].y - 2000.0;
        outPos.z = vtxData.position[inIndex].z;
        outPos.w = 1.0;
        gl_MeshVerticesEXT[outIndex].gl_Position = outPos;
        gl_MeshVerticesEXT[outIndex].gl_PointSize = 1.0;
    }
    gl_PrimitivePointIndicesEXT[col] = baseOutVertex;
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (points) out;
layout (max_vertices=64, max_primitives=64) out;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) readonly buffer PositionsArray { vec4 position[]; } vtxData;
void main (void) {
    const uint primitiveVertices = 1;
    const uint row = gl_WorkGroupID.x;
    const uint col = gl_LocalInvocationIndex;
    const uint pixelIdx = row * 64 + col;
    const uint baseInVertex = pixelIdx * primitiveVertices;
    const uint baseOutVertex = col * primitiveVertices;
    SetMeshOutputsEXT(64, 64);
    for (uint i = 0u; i < primitiveVertices; ++i) {
        const uint inIndex = baseInVertex + i;
        const uint outIndex = baseOutVertex + i;
        vec4 outPos;
        outPos.x = vtxData.position[inIndex].x - 1000.0;
        outPos.y = vtxData.position[inIndex].y - 2000.0;
        outPos.z = vtxData.position[inIndex].z;
        outPos.w = 1.0;
        gl_MeshVerticesEXT[outIndex].gl_Position.x = outPos.x;
        gl_MeshVerticesEXT[outIndex].gl_Position.y = outPos.y;
        gl_MeshVerticesEXT[outIndex].gl_Position.z = outPos.z;
        gl_MeshVerticesEXT[outIndex].gl_Position.w = outPos.w;
        gl_MeshVerticesEXT[outIndex].gl_PointSize = 1.0;
    }
    gl_PrimitivePointIndicesEXT[col] = baseOutVertex;
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (triangles) out;
layout (max_vertices=192, max_primitives=64) out;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) readonly buffer PositionsArray { vec4 position[]; } vtxData;
void main (void) {
    const uint primitiveVertices = 3;
    const uint row = gl_WorkGroupID.x;
    const uint col = gl_LocalInvocationIndex;
    const uint pixelIdx = row * 64 + col;
    const uint baseInVertex = pixelIdx * primitiveVertices;
    const uint baseOutVertex = col * primitiveVertices;
    SetMeshOutputsEXT(192, 64);
    for (uint i = 0u; i < primitiveVertices; ++i) {
        const uint inIndex = baseInVertex + i;
        const uint outIndex = baseOutVertex + i;
        vec4 outPos;
        outPos.x = vtxData.position[inIndex].x - 1000.0;
        outPos.y = vtxData.position[inIndex].y - 2000.0;
        outPos.z = vtxData.position[inIndex].z;
        outPos.w = 1.0;
        gl_MeshVerticesEXT[outIndex].gl_Position = outPos;
        gl_MeshVerticesEXT[outIndex].gl_PointSize = 1.0;
    }
    gl_PrimitiveTriangleIndicesEXT[col] = uvec3(baseOutVertex, baseOutVertex + 1u, baseOutVertex + 2u);
}
#version 460
#extension GL_EXT_mesh_shader : enable
layout (triangles) out;
layout (max_vertices=192, max_primitives=64) out;
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, std430) readonly buffer PositionsArray { vec4 position[]; } vtxData;
void main (void) {
    const uint primitiveVertices = 3;
    const uint row = gl_WorkGroupID.x;
    const uint col = gl_LocalInvocationIndex;
    const uint pixelIdx = row * 64 + col;
    const uint baseInVertex = pixelIdx * primitiveVertices;
    const uint baseOutVertex = col * primitiveVertices;
    SetMeshOutputsEXT(192, 64);
    for (uint i = 0u; i < primitiveVertices; ++i) {
        const uint inIndex = baseInVertex + i;
        const uint outIndex = baseOutVertex + i;
        vec4 outPos;
        outPos.x = vtxData.position[inIndex].x - 1000.0;
        outPos.y = vtxData.position[inIndex].y - 2000.0;
        outPos.z = vtxData.position[inIndex].z;
        outPos.w = 1.0;
        gl_MeshVerticesEXT[outIndex].gl_Position.x = outPos.x;
        gl_MeshVerticesEXT[outIndex].gl_Position.y = outPos.y;
        gl_MeshVerticesEXT[outIndex].gl_Position.z = outPos.z;
        gl_MeshVerticesEXT[outIndex].gl_Position.w = outPos.w;
        gl_MeshVerticesEXT[outIndex].gl_PointSize = 1.0;
    }
    gl_PrimitiveTriangleIndicesEXT[col] = uvec3(baseOutVertex, baseOutVertex + 1u, baseOutVertex + 2u);
}
