#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT float redColor;
layout (location=1) in flat float greenColor;
layout (location=0) out vec4 outColor;
void main(void) {
    const float blueColor = 1;
    outColor = vec4(redColor, greenColor, blueColor, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

struct VertexData {
    vec4 position;
    vec4 extraData;
};

layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {
    VertexData vertexData[];
} vtxData;
layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=96, max_primitives=32) out;

layout (location=0) out perprimitiveEXT float redColor[];
layout (location=1) out flat float greenColor[];

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint triangleVertices = 3;
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex] + wgIndex;
    const uint srcBasePrim = rowIndex * pc.width;
    const uint srcPrim = srcBasePrim + gl_LocalInvocationIndex;
    const uint srcBaseVertex = srcPrim * triangleVertices;
    const uint dstPrim = gl_LocalInvocationIndex;
    const uint dstBaseVertex = dstPrim * triangleVertices;
    SetMeshOutputsEXT(96, 32);
    for (uint i = 0u; i < triangleVertices; ++i) {
        const uint dstIdx = dstBaseVertex + i;
        const uint srcIdx = srcBaseVertex + i;
        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;
        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;
        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;
        greenColor[dstIdx] = 0;
    }
    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);
    redColor[dstPrim] = 0.25;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT float redColor;
layout (location=1) in flat float greenColor;
layout (location=0) out vec4 outColor;
void main(void) {
    const float blueColor = 0.5;
    outColor = vec4(redColor, greenColor, blueColor, 1.0);
}
#version 460
#extension GL_EXT_mesh_shader : enable

struct VertexData {
    vec4 position;
    vec4 extraData;
};

layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {
    VertexData vertexData[];
} vtxData;
layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=96, max_primitives=32) out;

layout (location=0) out perprimitiveEXT float redColor[];
layout (location=1) out flat float greenColor[];

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint triangleVertices = 3;
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex] + wgIndex;
    const uint srcBasePrim = rowIndex * pc.width;
    const uint srcPrim = srcBasePrim + gl_LocalInvocationIndex;
    const uint srcBaseVertex = srcPrim * triangleVertices;
    const uint dstPrim = gl_LocalInvocationIndex;
    const uint dstBaseVertex = dstPrim * triangleVertices;
    SetMeshOutputsEXT(96, 32);
    for (uint i = 0u; i < triangleVertices; ++i) {
        const uint dstIdx = dstBaseVertex + i;
        const uint srcIdx = srcBaseVertex + i;
        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;
        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;
        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;
        greenColor[dstIdx] = 1;
    }
    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);
    redColor[dstPrim] = 0.75;
}
#version 460
#extension GL_EXT_mesh_shader : enable

struct VertexData {
    vec4 position;
    vec4 extraData;
};

layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {
    VertexData vertexData[];
} vtxData;
layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;

struct TaskData {
    uint rowIndex;          // Set by first task invocation.
    uint columnIndices[32]; // 2 of these items per task invocation.
};
taskPayloadSharedEXT TaskData td;
layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT float redColor[];
layout (location=1) out flat float greenColor[];

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint triangleVertices = 3;
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = td.rowIndex;
    const uint srcBasePrim = rowIndex * pc.width;
    const uint srcPrim = srcBasePrim + td.columnIndices[wgIndex];
    const uint srcBaseVertex = srcPrim * triangleVertices;
    const uint dstPrim = gl_LocalInvocationIndex;
    const uint dstBaseVertex = dstPrim * triangleVertices;
    SetMeshOutputsEXT(3, 1);
    for (uint i = 0u; i < triangleVertices; ++i) {
        const uint dstIdx = dstBaseVertex + i;
        const uint srcIdx = srcBaseVertex + i;
        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;
        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;
        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;
        greenColor[dstIdx] = 0;
    }
    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);
    redColor[dstPrim] = 0.25;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;
layout (set=0, binding=2, std430) readonly buffer CoverageBlock { uint colsPerRow[32]; } cb;

struct TaskData {
    uint rowIndex;          // Set by first task invocation.
    uint columnIndices[32]; // 2 of these items per task invocation.
};
taskPayloadSharedEXT TaskData td;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=16) in;

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex] + wgIndex;
    td.rowIndex = rowIndex;
    const uint baseEntryIdx = gl_LocalInvocationIndex * 2u;
    for (uint i = 0u; i < 2u; ++i) {
        const uint idx = baseEntryIdx + i;
        const uint value = uint(0 + ((1) * int(idx)));
        td.columnIndices[idx] = value;
    }
    EmitMeshTasksEXT(cb.colsPerRow[rowIndex], 1, 1);
}
#version 460
#extension GL_EXT_mesh_shader : enable

struct VertexData {
    vec4 position;
    vec4 extraData;
};

layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {
    VertexData vertexData[];
} vtxData;
layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;

struct TaskData {
    uint rowIndex;          // Set by first task invocation.
    uint columnIndices[32]; // 2 of these items per task invocation.
};
taskPayloadSharedEXT TaskData td;
layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

layout (location=0) out perprimitiveEXT float redColor[];
layout (location=1) out flat float greenColor[];

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint triangleVertices = 3;
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = td.rowIndex;
    const uint srcBasePrim = rowIndex * pc.width;
    const uint srcPrim = srcBasePrim + td.columnIndices[wgIndex];
    const uint srcBaseVertex = srcPrim * triangleVertices;
    const uint dstPrim = gl_LocalInvocationIndex;
    const uint dstBaseVertex = dstPrim * triangleVertices;
    SetMeshOutputsEXT(3, 1);
    for (uint i = 0u; i < triangleVertices; ++i) {
        const uint dstIdx = dstBaseVertex + i;
        const uint srcIdx = srcBaseVertex + i;
        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;
        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;
        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;
        greenColor[dstIdx] = 1;
    }
    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);
    redColor[dstPrim] = 0.75;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;
layout (set=0, binding=2, std430) readonly buffer CoverageBlock { uint colsPerRow[32]; } cb;

struct TaskData {
    uint rowIndex;          // Set by first task invocation.
    uint columnIndices[32]; // 2 of these items per task invocation.
};
taskPayloadSharedEXT TaskData td;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=16) in;

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex] + wgIndex;
    td.rowIndex = rowIndex;
    const uint baseEntryIdx = gl_LocalInvocationIndex * 2u;
    for (uint i = 0u; i < 2u; ++i) {
        const uint idx = baseEntryIdx + i;
        const uint value = uint(31 + ((-1) * int(idx)));
        td.columnIndices[idx] = value;
    }
    EmitMeshTasksEXT(cb.colsPerRow[rowIndex], 1, 1);
}
#version 460
#extension GL_EXT_mesh_shader : enable

struct VertexData {
    vec4 position;
    vec4 extraData;
};

layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {
    VertexData vertexData[];
} vtxData;
layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=96, max_primitives=32) out;

layout (location=0) out perprimitiveEXT float redColor[];
layout (location=1) out flat float greenColor[];

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint triangleVertices = 3;
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex + uint(gl_DrawID)] + wgIndex;
    const uint srcBasePrim = rowIndex * pc.width;
    const uint srcPrim = srcBasePrim + gl_LocalInvocationIndex;
    const uint srcBaseVertex = srcPrim * triangleVertices;
    const uint dstPrim = gl_LocalInvocationIndex;
    const uint dstBaseVertex = dstPrim * triangleVertices;
    SetMeshOutputsEXT(96, 32);
    for (uint i = 0u; i < triangleVertices; ++i) {
        const uint dstIdx = dstBaseVertex + i;
        const uint srcIdx = srcBaseVertex + i;
        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;
        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;
        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;
        greenColor[dstIdx] = 0;
    }
    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);
    redColor[dstPrim] = 0.25;
}
#version 460
#extension GL_EXT_mesh_shader : enable

struct VertexData {
    vec4 position;
    vec4 extraData;
};

layout(set=0, binding=0, std430) readonly buffer VertexDataBlock {
    VertexData vertexData[];
} vtxData;
layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=32) in;
layout(triangles) out;
layout(max_vertices=96, max_primitives=32) out;

layout (location=0) out perprimitiveEXT float redColor[];
layout (location=1) out flat float greenColor[];

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint triangleVertices = 3;
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex + uint(gl_DrawID)] + wgIndex;
    const uint srcBasePrim = rowIndex * pc.width;
    const uint srcPrim = srcBasePrim + gl_LocalInvocationIndex;
    const uint srcBaseVertex = srcPrim * triangleVertices;
    const uint dstPrim = gl_LocalInvocationIndex;
    const uint dstBaseVertex = dstPrim * triangleVertices;
    SetMeshOutputsEXT(96, 32);
    for (uint i = 0u; i < triangleVertices; ++i) {
        const uint dstIdx = dstBaseVertex + i;
        const uint srcIdx = srcBaseVertex + i;
        gl_MeshVerticesEXT[dstIdx].gl_Position = vtxData.vertexData[srcIdx].position;
        gl_MeshVerticesEXT[dstIdx].gl_PointSize = 1.0;
        gl_MeshVerticesEXT[dstIdx].gl_ClipDistance[0] = vtxData.vertexData[srcIdx].extraData.x;
        gl_MeshVerticesEXT[dstIdx].gl_CullDistance[0] = vtxData.vertexData[srcIdx].extraData.y;
        greenColor[dstIdx] = 1;
    }
    gl_PrimitiveTriangleIndicesEXT[dstPrim] = uvec3(dstBaseVertex + 0, dstBaseVertex + 1, dstBaseVertex + 2);
    redColor[dstPrim] = 0.75;
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;
layout (set=0, binding=2, std430) readonly buffer CoverageBlock { uint colsPerRow[32]; } cb;

struct TaskData {
    uint rowIndex;          // Set by first task invocation.
    uint columnIndices[32]; // 2 of these items per task invocation.
};
taskPayloadSharedEXT TaskData td;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=16) in;

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex + uint(gl_DrawID)] + wgIndex;
    td.rowIndex = rowIndex;
    const uint baseEntryIdx = gl_LocalInvocationIndex * 2u;
    for (uint i = 0u; i < 2u; ++i) {
        const uint idx = baseEntryIdx + i;
        const uint value = uint(0 + ((1) * int(idx)));
        td.columnIndices[idx] = value;
    }
    EmitMeshTasksEXT(cb.colsPerRow[rowIndex], 1, 1);
}
#version 460
#extension GL_EXT_mesh_shader : enable

layout(set=0, binding=1, std430) readonly buffer DirectDrawBaseRowBlock {
    uint baseRow[];
} directDrawData;
layout (set=0, binding=2, std430) readonly buffer CoverageBlock { uint colsPerRow[32]; } cb;

struct TaskData {
    uint rowIndex;          // Set by first task invocation.
    uint columnIndices[32]; // 2 of these items per task invocation.
};
taskPayloadSharedEXT TaskData td;

layout (push_constant, std430) uniform PushConstantBlock {
    uint width;
    uint height;
    uint baseDrawIndex;
} pc;

layout(local_size_x=16) in;

uint getWorkGroupIndex (void) {
    const uint workGroupIndex = gl_NumWorkGroups.x * gl_NumWorkGroups.y * gl_WorkGroupID.z +
                                gl_NumWorkGroups.x * gl_WorkGroupID.y +
                                gl_WorkGroupID.x;
    return workGroupIndex;
}

void main() {
    const uint wgIndex = getWorkGroupIndex();
    const uint rowIndex = directDrawData.baseRow[pc.baseDrawIndex + uint(gl_DrawID)] + wgIndex;
    td.rowIndex = rowIndex;
    const uint baseEntryIdx = gl_LocalInvocationIndex * 2u;
    for (uint i = 0u; i < 2u; ++i) {
        const uint idx = baseEntryIdx + i;
        const uint value = uint(31 + ((-1) * int(idx)));
        td.columnIndices[idx] = value;
    }
    EmitMeshTasksEXT(cb.colsPerRow[rowIndex], 1, 1);
}
