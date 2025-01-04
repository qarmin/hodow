#version 460

layout (location=0) in vec4 inPos;
layout (location=1) in vec4 inColor;
layout (location=2) in ivec4 inExtra;

layout (location=0) out vec4 outColor;
layout (location=1) out flat ivec4 outExtra;

void main (void)
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;

    outColor = inColor;
    outExtra = inExtra;
}
