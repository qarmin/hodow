#version 450
#extension GL_EXT_mesh_shader : enable
#extension GL_EXT_multiview : enable

layout (location=0) out uvec4 outColor;

void main (void) {
    outColor = uvec4(uint(gl_ViewIndex) + 1u, 0, 0, 0);
}
