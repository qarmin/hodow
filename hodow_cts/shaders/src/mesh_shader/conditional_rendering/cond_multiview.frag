#version 460
#extension GL_EXT_multiview : enable

layout (location=0) out vec4 outColor;

void main (void) {
    outColor = vec4(gl_ViewIndex, 0.0, 1.0, 1.0);
}
