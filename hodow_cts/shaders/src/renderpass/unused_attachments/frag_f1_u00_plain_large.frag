#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out vec4 color1;
layout (location=2) out vec4 color2;
layout (location=3) out vec4 color3;
layout (location=4) out vec4 color4;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(1.0f, 1.0f, 0.00392157f , 1.0f);
    color2 = uvec4(1.0f, 1.0f, 0.00784314f , 1.0f);
    color3 = uvec4(1.0f, 1.0f, 0.0117647f , 1.0f);
    color4 = uvec4(1.0f, 1.0f, 0.0156863f , 1.0f);
}
