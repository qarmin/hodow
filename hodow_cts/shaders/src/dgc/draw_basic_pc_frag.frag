#version 460
layout (push_constant, std430) uniform PCBlock { vec4 color; } pc;
layout (location=0) out vec4 outColor;
void main (void) {
    outColor = pc.color;
}
