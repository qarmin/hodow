#version 460
layout (location=0) in vec4 inPos;
void main (void) {
    gl_PointSize = 1.0;
    gl_Position = inPos;
}
