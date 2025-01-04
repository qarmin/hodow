#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color = uvec4(layerIndex, 255, 0, 255);
}
