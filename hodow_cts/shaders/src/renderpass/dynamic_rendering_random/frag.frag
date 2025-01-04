#version 450

layout(location = 0) in vec4 vsColor;
layout(location = 0) out vec4 fsColor;

void main (void)
{
    fsColor   = vsColor;
    fsColor.z = 0.0f;
}
