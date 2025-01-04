#version 450

layout (push_constant, std430) uniform PushConstantBlock {
    float geometryDepth;
    float minDepth;
    float maxDepth;
} pc;

vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0)
);

void main() {
    gl_Position = vec4(positions[gl_VertexIndex], pc.geometryDepth, 1.0);
}
#version 450

layout (push_constant, std430) uniform PushConstantBlock {
    float geometryDepth;
    float minDepth;
    float maxDepth;
} pc;

layout (location=0) out vec4 outColor;

void main() {
    const float depth = gl_FragCoord.z;
    if (depth >= pc.minDepth && depth <= pc.maxDepth) {
        outColor = vec4(0.0, 1.0, 0.0, 1.0);
    }
}
#version 450
#extension GL_EXT_mesh_shader : enable

layout (push_constant, std430) uniform PushConstantBlock {
    float geometryDepth;
    float minDepth;
    float maxDepth;
} pc;

vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(3.0, -1.0),
    vec2(-1.0, 3.0)
);

layout(local_size_x=3) in;
layout(triangles) out;
layout(max_vertices=3, max_primitives=1) out;

void main() {
    SetMeshOutputsEXT(3u, 1u);
    gl_MeshVerticesEXT[gl_LocalInvocationIndex].gl_Position = vec4(positions[gl_LocalInvocationIndex], pc.geometryDepth, 1.0);
    gl_PrimitiveTriangleIndicesEXT[0] = uvec3(0, 1, 2);
}
