#version 460
layout (location=0) in vec4 inPos0;
layout (location=1) in vec4 inPos1;
void main (void) {
    gl_Position = (gl_VertexIndex < 24) ? inPos0 : inPos1;
}
