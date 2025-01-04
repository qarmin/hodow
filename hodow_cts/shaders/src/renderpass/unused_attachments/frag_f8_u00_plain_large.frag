#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=8) out vec4 color8;
layout (location=9) out vec4 color9;
layout (location=10) out vec4 color10;
layout (location=11) out vec4 color11;
void main (void) {
    const uint layerIndex = 0u;
    color8 = uvec4(1.0f, 1.0f, 0.0313725f , 1.0f);
    color9 = uvec4(1.0f, 1.0f, 0.0352941f , 1.0f);
    color10 = uvec4(1.0f, 1.0f, 0.0392157f , 1.0f);
    color11 = uvec4(1.0f, 1.0f, 0.0431373f , 1.0f);
}
