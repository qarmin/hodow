#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) out vec4 fragColor;
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

void main (void)
{
    outVecs[outIndex][0] = inVecs[inIndex][0];
    outVecs[outIndex][1] = inVecs[inIndex][1];
    outVecs[outIndex][2] = inVecs[inIndex][2];
    outVecs[outIndex][3] = inVecs[inIndex][3];
    fragColor = vec4(1.0);
}
