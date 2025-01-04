#version 450

layout(set = 0, binding = 0) uniform uboVertexData
{
    vec4 position;
} inputPosData;

layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec4 inColor;
layout(location = 0) out vec4 outColor;

out gl_PerVertex
{
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = inPosition + inputPosData.position;
    outColor = inColor;
}
