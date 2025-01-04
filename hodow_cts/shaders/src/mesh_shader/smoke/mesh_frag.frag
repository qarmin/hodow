#version 450
#extension GL_EXT_mesh_shader : enable

layout (location=0) in perprimitiveEXT vec4 triangleColor;
layout (location=0) out vec4 outColor;

void main ()
{
    outColor = triangleColor;
}
