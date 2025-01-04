#version 450
#extension GL_EXT_mesh_shader : enable
layout(local_size_x=3, local_size_y=1, local_size_z=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
struct VertexData {
    vec2 position;
    vec2 padding;
};
layout(set=0, binding=0, std430) readonly buffer S0B0Block {
    VertexData data[];
} s0b0buffer;

void main() {
    uint prim = uint(gl_WorkGroupID.x);
    uint indices[3] = uint[](prim, (prim + (1 + prim % 2)), (prim + (2 - prim % 2)));
    uint invIndex = indices[gl_LocalInvocationIndex];
    vec2 vertexCoords = s0b0buffer.data[invIndex].position;
    SetMeshOutputsEXT(3u, 1u);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    if (gl_LocalInvocationIndex == 0u) {
        gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable
layout(local_size_x=3, local_size_y=1, local_size_z=1) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;
perprimitiveEXT out gl_MeshPerPrimitiveEXT { int gl_ViewportIndex; } gl_MeshPrimitivesEXT[];
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
struct VertexData {
    vec2 position;
    vec2 padding;
};
layout(set=0, binding=0, std430) readonly buffer S0B0Block {
    VertexData data[];
} s0b0buffer;

void main() {
    uint prim = uint(gl_WorkGroupID.x);
    uint indices[3] = uint[](prim, (prim + (1 + prim % 2)), (prim + (2 - prim % 2)));
    uint invIndex = indices[gl_LocalInvocationIndex];
    vec2 vertexCoords = s0b0buffer.data[invIndex].position;
    SetMeshOutputsEXT(3u, 1u);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(vertexCoords.x * pushConstants.scaleX + pushConstants.offsetX, vertexCoords.y * pushConstants.scaleY + pushConstants.offsetY, pushConstants.depthValue, 1.0);
    if (gl_LocalInvocationIndex == 0u) {
        gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
        gl_MeshPrimitivesEXT[0].gl_ViewportIndex = pushConstants.viewPortIndex;
    }
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
}
#version 450
layout(push_constant, std430) uniform PushConstantsBlock {
    vec4  triangleColor;
    float depthValue;
    int   viewPortIndex;
    float scaleX;
    float scaleY;
    float offsetX;
    float offsetY;
    float stripScale;
} pushConstants;
layout(location=0) out uvec4 color;
void main() {
    color = uvec4(pushConstants.triangleColor);
}
