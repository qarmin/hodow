#version 460
layout (location=0) in vec4 inPos;
layout (location=1) in vec2 inCoords;
layout (location=0) out vec2 outCoords;
void main (void) {
    gl_Position = inPos;
    outCoords   = inCoords;
}
