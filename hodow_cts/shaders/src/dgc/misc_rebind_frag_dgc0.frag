#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock { uint seqIndex; } pc;
void main (void) {
    outColor = vec4(1.0, 0.0, float(pc.seqIndex), 1.0);
}
