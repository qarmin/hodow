#version 440
#extension GL_EXT_texture_buffer : require
precision highp float;
layout(location = 0) in vec4 position;

layout(binding = 0, std430) buffer InBuffer
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


out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    mat4 tmp = inMatrix[inIndex];
    outMatrix[outIndex] = tmp;
    gl_Position = position;
}
