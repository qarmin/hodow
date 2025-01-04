#version 450

layout(set = 0, binding = 1) uniform uboSharedData
{
    vec4 color;
} inputData0;

layout(set = 0, binding = 3) uniform uboFragOnly
{
    mat4 color;
} inputData1;

layout(location = 0) in vec4 inColor;
layout(location = 0) out vec4 outColor;

void main (void)
{
    outColor = inColor + inputData0.color;
    outColor.b = inputData1.color[3][3];
}
