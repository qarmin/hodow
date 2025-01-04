#version 460
#extension GL_EXT_fragment_shading_rate : enable
layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=0) out vec4 outColor;
void main (void) {
    gl_Position = inPos;
    outColor = inColor;
}
