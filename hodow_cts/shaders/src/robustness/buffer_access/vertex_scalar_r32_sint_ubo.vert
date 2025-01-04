#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std140) uniform InBuffer
{
    ivec4 inVecs[128][4];
};

layout(binding = 1, std430) buffer OutBuffer
{
    ivec4 outVecs[128][4];
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
    outVecs[outIndex][0][0] = inVecs[inIndex][0][0];
    outVecs[outIndex][0][1] = inVecs[inIndex][0][1];
    outVecs[outIndex][0][2] = inVecs[inIndex][0][2];
    outVecs[outIndex][0][3] = inVecs[inIndex][0][3];
    outVecs[outIndex][1][0] = inVecs[inIndex][1][0];
    outVecs[outIndex][1][1] = inVecs[inIndex][1][1];
    outVecs[outIndex][1][2] = inVecs[inIndex][1][2];
    outVecs[outIndex][1][3] = inVecs[inIndex][1][3];
    outVecs[outIndex][2][0] = inVecs[inIndex][2][0];
    outVecs[outIndex][2][1] = inVecs[inIndex][2][1];
    outVecs[outIndex][2][2] = inVecs[inIndex][2][2];
    outVecs[outIndex][2][3] = inVecs[inIndex][2][3];
    outVecs[outIndex][3][0] = inVecs[inIndex][3][0];
    outVecs[outIndex][3][1] = inVecs[inIndex][3][1];
    outVecs[outIndex][3][2] = inVecs[inIndex][3][2];
    outVecs[outIndex][3][3] = inVecs[inIndex][3][3];
    gl_Position = position;
}
