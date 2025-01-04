#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer readonly InBuffer
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
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    gl_Position = position;
}
