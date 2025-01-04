#version 460
#extension GL_EXT_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_PrimitiveID == 1629198956) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));
}
