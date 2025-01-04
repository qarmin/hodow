#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
