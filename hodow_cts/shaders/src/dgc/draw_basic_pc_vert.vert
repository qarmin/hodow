#version 460
layout (location=0) in vec4 inPos;
layout (push_constant, std430) uniform PCBlock { layout(offset=16) float ptSize; } pc;
void main (void) {
    gl_Position = inPos;
    const float pointSize = pc.ptSize;
    gl_PointSize = pointSize;
}
