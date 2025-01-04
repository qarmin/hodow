#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
