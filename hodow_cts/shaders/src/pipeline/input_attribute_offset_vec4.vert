#version 460
layout (location=0) in vec4 inPos;
void main (void) { gl_Position = vec4(inPos); }
