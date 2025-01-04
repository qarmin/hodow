#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=4) out vec4 color4;
layout (location=5) out vec4 color5;
layout (location=6) out vec4 color6;
layout (location=7) out vec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(1.0f, 1.0f, 0.0156863f , 1.0f);
    color5 = uvec4(1.0f, 1.0f, 0.0196078f , 1.0f);
    color6 = uvec4(1.0f, 1.0f, 0.0235294f , 1.0f);
    color7 = uvec4(1.0f, 1.0f, 0.027451f , 1.0f);
}
