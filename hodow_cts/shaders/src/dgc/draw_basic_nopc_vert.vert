#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_Position = inPos;
    const float pointSize = 1.0;
    gl_PointSize = pointSize;
}
