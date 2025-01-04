#version 460

layout (location=0) flat in uvec4 inColor;
layout (location=0) out uvec4 outColor;

void main ()
{
    outColor = inColor;
}
