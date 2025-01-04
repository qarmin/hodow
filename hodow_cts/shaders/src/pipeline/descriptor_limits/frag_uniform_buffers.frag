#version 450

layout(location = 0) out vec4 fragColor;

layout(set = 0, binding = ${binding}) uniform uboInput
{
    vec4 color;
} inputData;


void main (void)
{
    fragColor = inputData.color;
}
