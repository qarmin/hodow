#version 460
#extension GL_EXT_mesh_shader : enable

// 32 local invocations in total.
layout (local_size_x=4, local_size_y=2, local_size_z=4) in;
layout (triangles) out;
layout (max_vertices=96, max_primitives=32) out;

layout (push_constant, std430) uniform MeshPushConstantBlock {
    uint width;
    uint height;
    uint dimCoord;
} pc;

layout (location=0) perprimitiveEXT out vec4 primitiveColor[];


layout (set=0, binding=0, std430) readonly buffer BlockSizes {
    uint blockSize[];
} bsz;

uint startOfBlock (uint blockNumber)
{
    uint start = 0;
    for (uint i = 0; i < blockNumber; i++)
        start += bsz.blockSize[i];
    return start;
}

void main ()
{
    const uint workGroupID = ((pc.dimCoord == 2) ? gl_WorkGroupID.z : ((pc.dimCoord == 1) ? gl_WorkGroupID.y : gl_WorkGroupID.x));
    const uint blockNumber = uint(gl_DrawID);
    const uint blockRow = workGroupID;

    // Each workgroup will fill one row, and each invocation will generate a
    // triangle around the pixel center in each column.
    const uint row = startOfBlock(blockNumber) + blockRow;
    const uint col = gl_LocalInvocationIndex;

    const float fHeight = float(pc.height);
    const float fWidth = float(pc.width);

    // Pixel coordinates, normalized.
    const float rowNorm = (float(row) + 0.5) / fHeight;
    const float colNorm = (float(col) + 0.5) / fWidth;

    // Framebuffer coordinates.
    const float coordX = (colNorm * 2.0) - 1.0;
    const float coordY = (rowNorm * 2.0) - 1.0;

    const float pixelWidth = 2.0 / fWidth;
    const float pixelHeight = 2.0 / fHeight;

    const float offsetX = pixelWidth / 2.0;
    const float offsetY = pixelHeight / 2.0;

    const uint baseIndex = col*3;
    const uvec3 indices = uvec3(baseIndex, baseIndex + 1, baseIndex + 2);

    SetMeshOutputsEXT(96u, 32u);
    primitiveColor[col] = vec4(rowNorm, colNorm, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[col] = uvec3(indices.x, indices.y, indices.z);

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(coordX - offsetX, coordY + offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(coordX + offsetX, coordY + offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(coordX, coordY - offsetY, 0.0, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) perprimitiveEXT in vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (local_size_x=1) in;

layout (push_constant, std430) uniform TaskPushConstantBlock {
    layout (offset=12) uint one;
    layout (offset=16) uint dimCoord;
} pc;

struct TaskData {
    uint blockNumber;
    uint blockRow;
};
taskPayloadSharedEXT TaskData td;

void main ()
{
    const uint workGroupID = ((pc.dimCoord == 2) ? gl_WorkGroupID.z : ((pc.dimCoord == 1) ? gl_WorkGroupID.y : gl_WorkGroupID.x));
    td.blockNumber         = uint(gl_DrawID);
    td.blockRow            = workGroupID;
    EmitMeshTasksEXT(pc.one, pc.one, pc.one);}
#version 460
#extension GL_EXT_mesh_shader : enable

// 32 local invocations in total.
layout (local_size_x=4, local_size_y=2, local_size_z=4) in;
layout (triangles) out;
layout (max_vertices=96, max_primitives=32) out;

layout (push_constant, std430) uniform MeshPushConstantBlock {
    uint width;
    uint height;
    uint dimCoord;
} pc;

layout (location=0) perprimitiveEXT out vec4 primitiveColor[];

struct TaskData {
    uint blockNumber;
    uint blockRow;
};
taskPayloadSharedEXT TaskData td;

layout (set=0, binding=0, std430) readonly buffer BlockSizes {
    uint blockSize[];
} bsz;

uint startOfBlock (uint blockNumber)
{
    uint start = 0;
    for (uint i = 0; i < blockNumber; i++)
        start += bsz.blockSize[i];
    return start;
}

void main ()
{
    const uint workGroupID = ((pc.dimCoord == 2) ? gl_WorkGroupID.z : ((pc.dimCoord == 1) ? gl_WorkGroupID.y : gl_WorkGroupID.x));
    const uint blockNumber = td.blockNumber;
    const uint blockRow = td.blockRow;

    // Each workgroup will fill one row, and each invocation will generate a
    // triangle around the pixel center in each column.
    const uint row = startOfBlock(blockNumber) + blockRow;
    const uint col = gl_LocalInvocationIndex;

    const float fHeight = float(pc.height);
    const float fWidth = float(pc.width);

    // Pixel coordinates, normalized.
    const float rowNorm = (float(row) + 0.5) / fHeight;
    const float colNorm = (float(col) + 0.5) / fWidth;

    // Framebuffer coordinates.
    const float coordX = (colNorm * 2.0) - 1.0;
    const float coordY = (rowNorm * 2.0) - 1.0;

    const float pixelWidth = 2.0 / fWidth;
    const float pixelHeight = 2.0 / fHeight;

    const float offsetX = pixelWidth / 2.0;
    const float offsetY = pixelHeight / 2.0;

    const uint baseIndex = col*3;
    const uvec3 indices = uvec3(baseIndex, baseIndex + 1, baseIndex + 2);

    SetMeshOutputsEXT(96u, 32u);
    primitiveColor[col] = vec4(rowNorm, colNorm, 0.0, 1.0);
    gl_PrimitiveTriangleIndicesEXT[col] = uvec3(indices.x, indices.y, indices.z);

    gl_MeshVerticesEXT[indices.x].gl_Position = vec4(coordX - offsetX, coordY + offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.y].gl_Position = vec4(coordX + offsetX, coordY + offsetY, 0.0, 1.0);
    gl_MeshVerticesEXT[indices.z].gl_Position = vec4(coordX, coordY - offsetY, 0.0, 1.0);
}
