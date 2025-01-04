#version 460
${ext}layout (location=0) in vec4 inPos;
layout (location=0) out flat int layerIndex;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    layerIndex = gl_InstanceIndex;
${layer}}
