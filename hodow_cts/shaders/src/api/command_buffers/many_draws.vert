#version 450

layout(location=0) in vec2 inCoords;
layout(location=1) in uvec4 inColor;

layout(location=0) out flat uvec4 outColor;

void main()
{
    gl_Position = vec4(inCoords, 0.0, 1.0);
    outColor = inColor;
}
