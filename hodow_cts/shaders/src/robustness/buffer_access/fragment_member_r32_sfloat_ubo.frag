#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
layout(binding = 0, std140) uniform InBuffer
{
    vec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    vec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    fragColor = vec4(1.0);
}
