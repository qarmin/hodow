#version 450
layout(early_fragment_tests) in;
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
layout(set=0, binding=0, std430) buffer AtomicBlock { uint fragCounter; } counterBuffer;
layout(location=0) out vec4 color;
void main() {
    color = vec4(pushConstants.triangleColor);
    atomicAdd(counterBuffer.fragCounter, 1u);
}
