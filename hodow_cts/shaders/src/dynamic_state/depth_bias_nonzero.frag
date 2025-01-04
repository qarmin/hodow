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
