#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
}
