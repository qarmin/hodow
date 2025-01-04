#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 scale; vec4 offset; } pc;
layout (location=1) out float red;
layout (location=4) out float blue;
void main (void) {
    red = 0.5;
    blue = inPos.x;
    gl_Position = inPos * pc.scale + pc.offset;
}
