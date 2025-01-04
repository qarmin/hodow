#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 scale; vec4 offset; } pc;
layout (location=2) out float red;
void main (void) {
    red = inPos.x;
    gl_Position = inPos * pc.scale + pc.offset;
}
