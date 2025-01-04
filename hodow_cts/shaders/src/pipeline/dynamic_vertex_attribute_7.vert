#version 450

layout(location = 0) in vec4 inPosition;
layout(location = 7) in vec4 inColor;
layout(location = 0) out vec4 outColor;

void main (void)
{
    gl_Position = inPosition;
    outColor = inColor;
}
