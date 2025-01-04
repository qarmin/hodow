#version 460
#extension GL_EXT_mesh_shader : require

layout(local_size_x=64, local_size_y=1, local_size_z=1) in;

struct GlobalIndices {
    uint values[256];
};
taskPayloadSharedEXT GlobalIndices globalIndices;
layout (push_constant, std430) uniform PushConstantBlock {
    vec4 colorMultiplier;   // vec4(1.0, 1.0, 1.0, 1.0)
    uint wgIndexMultiplier; // 1
} pc;

void main() {
    const uint totalTaskWGs = 256u; // Must match the vkCmdDrawMeshTasksEXT() call
    const uint childMeshWGs = 256u; // Per task WG
    const uint globalIndex = gl_WorkGroupID.x;
    const uint wgLoad = totalTaskWGs - globalIndex; // More load the lower the WG index
    const uint indicesPerInv = childMeshWGs / gl_WorkGroupSize.x;
    for (uint i = 0u; i < indicesPerInv; ++i) {
        const uint idx = gl_LocalInvocationIndex * indicesPerInv + i;
        uint globalIndex = gl_WorkGroupID.x * childMeshWGs + idx;
        for (uint i = 0u; i < wgLoad; ++i) {
            globalIndex = globalIndex * pc.wgIndexMultiplier;
        }
        globalIndices.values[idx] = globalIndex;
    }
    EmitMeshTasksEXT(childMeshWGs, 1, 1);
}
#version 460
#extension GL_EXT_mesh_shader : require

layout(local_size_x=64, local_size_y=1, local_size_z=1) in;
layout(triangles, max_vertices=192, max_primitives=64) out;

struct GlobalIndices {
    uint values[256];
};
taskPayloadSharedEXT GlobalIndices globalIndices;
layout (push_constant, std430) uniform PushConstantBlock {
    vec4 colorMultiplier;   // vec4(1.0, 1.0, 1.0, 1.0)
    uint wgIndexMultiplier; // 1
} pc;

struct PositionColor {
    vec4 position;
    vec4 color;
};
layout (set=0, binding=0, std430) readonly buffer BufferBlock {
    PositionColor values[];
} geomData;

layout (location=0) out vec4 vertexColor[];

void main() {
    // invIndex is used so geometry is stored in reverse order compared to invocations
    const uint invIndex = gl_WorkGroupSize.x - gl_LocalInvocationIndex - 1u;
    const uint globalIndex = globalIndices.values[gl_WorkGroupID.x];
    const uint globalTriangleIndex = globalIndex * gl_WorkGroupSize.x + invIndex;
    const uint baseVtxIdx = invIndex * 3u;
    const uint wgLoad = gl_NumWorkGroups.x - gl_WorkGroupID.x; // More load the lower the WG index
    SetMeshOutputsEXT(192, 64);
    for (uint i = 0u; i < 3u; ++i)
    {
        const uint globalVertexIndex = globalTriangleIndex * 3u + i;
        const uint localVertexIndex = baseVtxIdx + i;
        gl_MeshVerticesEXT[localVertexIndex].gl_Position = geomData.values[globalVertexIndex].position;
        vec4 color = geomData.values[globalVertexIndex].color;
        for (uint i = 0u; i < wgLoad; ++i) {
            color = color * pc.colorMultiplier;
        }
        vertexColor[localVertexIndex] = color;
    }
    gl_PrimitiveTriangleIndicesEXT[invIndex] = uvec3(baseVtxIdx, baseVtxIdx + 1u, baseVtxIdx + 2u);
}
#version 460
layout (location=0) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = inColor;
}
