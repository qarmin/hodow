#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
