#version 460
#extension GL_NV_mesh_shader : enable

layout (location=0) out vec4 outColor;

void main ()
{
    outColor = ((gl_CullDistance[1] >= 0.0) ? vec4(0.0, 0.0, 1.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0));
}
