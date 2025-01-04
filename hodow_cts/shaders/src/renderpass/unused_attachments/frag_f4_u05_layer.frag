#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
}
