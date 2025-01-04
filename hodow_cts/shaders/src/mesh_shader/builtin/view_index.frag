#version 460
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) perprimitiveEXT in vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
