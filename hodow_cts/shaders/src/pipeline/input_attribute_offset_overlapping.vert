#version 460
layout (location=0) in vec4 inPos;
void main (void) { gl_Position = vec4(inPos.xy, floor(abs(inPos.z) / 1000.0), (floor(abs(inPos.w) / 2500.0) + 1.0)); }
