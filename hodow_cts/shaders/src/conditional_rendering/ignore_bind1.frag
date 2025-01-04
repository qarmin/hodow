#version 460
layout (location=0) out vec4 outColor;
layout (set=0, binding=0, std430) readonly buffer ColorBlock { vec4 colorA; vec4 colorB; } inColor;
void main (void) { outColor = inColor.colorB; }
