#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=6) out uvec4 color6;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
}
