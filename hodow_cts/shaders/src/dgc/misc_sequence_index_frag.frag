#version 460
layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;
layout (location=0) out uvec4 outColor;
void main(void) {
    outColor = uvec4(pc.seqIndex, 0u, 255u, 255u);
}
