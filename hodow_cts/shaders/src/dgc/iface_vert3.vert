#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 scale; vec4 offset; } pc;
layout (location=0) out float red;
layout (location=1) out float green;
layout (location=8) out float blue;
void main (void) {
    red = inPos.y;
    green = inPos.x;
    blue = 1.0;
    gl_Position = inPos * pc.scale + pc.offset;
}
