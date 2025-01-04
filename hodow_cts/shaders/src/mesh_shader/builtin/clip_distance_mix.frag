#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;
layout (location=0) in perprimitiveEXT vec4 triangleColor;

void main ()
{
    outColor = ((gl_ClipDistance[0] >= 0.0 && gl_ClipDistance[1] >= 0.0) ? triangleColor : vec4(1.0, 1.0, 1.0, 1.0));
}
