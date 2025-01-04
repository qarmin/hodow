#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
{
    uvec4 inVec;
};

layout(binding = 1, std430) buffer OutBuffer
{
    uvec4 outVec;
};

layout(binding = 2, std140) uniform Indices
{
    int inIndex;
    int outIndex;
};


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    outVec[outIndex] = inVec[inIndex];
    outVec[outIndex + 1] = inVec[inIndex + 1];
    outVec[outIndex + 2] = inVec[inIndex + 2];
    outVec[outIndex + 3] = inVec[inIndex + 3];
    gl_Position = position;
}
