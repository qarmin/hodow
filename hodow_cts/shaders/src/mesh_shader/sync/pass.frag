#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT flat uint primitiveValue;
layout (location=0) out uvec4 outColor;

void main ()
{
    outColor = uvec4(primitiveValue, 0, 0, 0);
}
