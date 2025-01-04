#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) perprimitiveNV in vec4 primitiveColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = primitiveColor;
}
