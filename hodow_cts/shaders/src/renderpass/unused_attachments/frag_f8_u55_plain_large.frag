#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=6) out uvec4 color6;
layout (location=8) out vec4 color8;
layout (location=9) out vec4 color9;
layout (location=10) out vec4 color10;
layout (location=11) out vec4 color11;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color8 = uvec4(1.0f, 1.0f, 0.0313725f , 1.0f);
    color9 = uvec4(1.0f, 1.0f, 0.0352941f , 1.0f);
    color10 = uvec4(1.0f, 1.0f, 0.0392157f , 1.0f);
    color11 = uvec4(1.0f, 1.0f, 0.0431373f , 1.0f);
}
