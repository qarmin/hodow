#version 460
#extension GL_EXT_multiview : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=5) out uvec4 color5;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
