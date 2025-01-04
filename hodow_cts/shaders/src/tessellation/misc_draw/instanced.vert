#version 460

layout (location = 0) in vec4 inPos;
layout (location = 1) in vec4 instancePos;

void main()
{
    vec4 pos = inPos + instancePos;

    gl_Position = pos;
}
