#version 460
layout (location=0) out vec4 outColor;
layout (push_constant, std430) uniform PCBlock { vec4 color; float depth; } pc;
void main(void) {
    outColor = pc.color;
}
