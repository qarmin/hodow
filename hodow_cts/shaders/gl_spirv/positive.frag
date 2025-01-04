#version 450

layout (location = 4) in vec4 gColor;
layout (location = 0) out vec4 fColor;

void main()
{
    fColor = gColor;
}
