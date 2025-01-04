#version 460
#extension GL_EXT_multiview : enable
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
