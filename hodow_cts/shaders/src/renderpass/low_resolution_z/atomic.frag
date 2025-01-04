#version 450
layout(push_constant) uniform PushConstant {
    vec4 color;
    float depth;
    float height;
    int mode;
} pc;
layout(location = 0) out vec4 fragColor;
layout(binding = 0) buffer Buf
{
    vec4 expectedEven;  // in, used for verification
    vec4 expectedOdd;   // in, used for verification
    uint isDifferent;   // out, verification expects this to be at index 8
    uint atomicValue;   // out, used only by atomic-frag
};
void main(void)
{
    atomicAdd(atomicValue, 1u);
    fragColor = pc.color;
}
