#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 scale; vec4 offset; } pc;
layout (location=5) out float red;
layout (location=6) out float green;
layout (location=10) out float blue;
layout (location=11) out float alpha;
void main (void) {
    red = 1.0;
    green = inPos.x;
    blue = 0.5;
    alpha = inPos.y;
    gl_Position = inPos * pc.scale + pc.offset;
}
