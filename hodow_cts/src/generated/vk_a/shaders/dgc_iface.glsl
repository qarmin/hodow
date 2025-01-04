#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { vec4 scale; vec4 offset; } pc;
layout (location=2) out float red;
void main (void) {
    red = inPos.x;
    gl_Position = inPos * pc.scale + pc.offset;
}
#version 460
layout (location=0) out vec4 outColor;
layout (location=2) in float red;
void main (void) {
    outColor = vec4(red, 0.0, 0.0, 1.0);
}
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
#version 460
layout (location=0) out vec4 outColor;
layout (location=5) in float red;
layout (location=6) in float green;
layout (location=10) in float blue;
layout (location=11) in float alpha;
void main (void) {
    outColor = vec4(red, green, blue, alpha);
}
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
#version 460
layout (location=0) out vec4 outColor;
layout (location=1) in float red;
layout (location=4) in float blue;
void main (void) {
    outColor = vec4(red, 1.0, blue, 1.0);
}
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
#version 460
layout (location=0) out vec4 outColor;
layout (location=0) in float red;
layout (location=1) in float green;
layout (location=8) in float blue;
void main (void) {
    outColor = vec4(red, green, blue, 1.0);
}
