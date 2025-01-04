#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    mat4 inMatrix[128];
};

layout(binding = 1, std430) buffer OutBuffer
{
    mat4 outMatrix[128];
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outMatrix[outIndex][0] = inMatrix[inIndex][0];
    outMatrix[outIndex][1] = inMatrix[inIndex][1];
    outMatrix[outIndex][2] = inMatrix[inIndex][2];
    outMatrix[outIndex][3] = inMatrix[inIndex][3];
    fragColor = vec4(1.0);
}
