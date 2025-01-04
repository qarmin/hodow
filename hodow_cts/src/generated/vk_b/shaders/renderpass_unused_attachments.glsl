#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (push_constant, std430) uniform PushConstantBlock { int layerIndex; } pc;
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  3.0),
    vec2( 3.0, -1.0)
);
void main() {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 1.0, 1.0);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
void main (void) {
    const uint layerIndex = 0u;
}
#version 460
#extension GL_EXT_multiview : enable
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (push_constant, std430) uniform PushConstantBlock { int layerIndex; } pc;
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2(-1.0,  3.0),
    vec2( 3.0, -1.0)
);
void main() {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 1.0, 1.0);
    gl_Layer = pc.layerIndex;
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
void main (void) {
    const uint layerIndex = uint(gl_Layer);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
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
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_EXT_multiview : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
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
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
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
#version 460
#extension GL_EXT_multiview : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=6) out uvec4 color6;
void main (void) {
    const uint layerIndex = uint(gl_ViewIndex);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=5) out uvec4 color5;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
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
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out uvec4 color4;
layout (location=6) out uvec4 color6;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=5) out uvec4 color5;
layout (location=7) out uvec4 color7;
void main (void) {
    const uint layerIndex = uint(gl_Layer);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out vec4 color1;
layout (location=2) out vec4 color2;
layout (location=3) out vec4 color3;
layout (location=4) out vec4 color4;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(1.0f, 1.0f, 0.00392157f , 1.0f);
    color2 = uvec4(1.0f, 1.0f, 0.00784314f , 1.0f);
    color3 = uvec4(1.0f, 1.0f, 0.0117647f , 1.0f);
    color4 = uvec4(1.0f, 1.0f, 0.0156863f , 1.0f);
}
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
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out vec4 color4;
layout (location=5) out vec4 color5;
layout (location=6) out vec4 color6;
layout (location=7) out vec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(1.0f, 1.0f, 0.0156863f , 1.0f);
    color5 = uvec4(1.0f, 1.0f, 0.0196078f , 1.0f);
    color6 = uvec4(1.0f, 1.0f, 0.0235294f , 1.0f);
    color7 = uvec4(1.0f, 1.0f, 0.027451f , 1.0f);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=4) out vec4 color4;
layout (location=5) out vec4 color5;
layout (location=6) out vec4 color6;
layout (location=7) out vec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color4 = uvec4(1.0f, 1.0f, 0.0156863f , 1.0f);
    color5 = uvec4(1.0f, 1.0f, 0.0196078f , 1.0f);
    color6 = uvec4(1.0f, 1.0f, 0.0235294f , 1.0f);
    color7 = uvec4(1.0f, 1.0f, 0.027451f , 1.0f);
}
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=2) out uvec4 color2;
layout (location=4) out vec4 color4;
layout (location=5) out vec4 color5;
layout (location=6) out vec4 color6;
layout (location=7) out vec4 color7;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color4 = uvec4(1.0f, 1.0f, 0.0156863f , 1.0f);
    color5 = uvec4(1.0f, 1.0f, 0.0196078f , 1.0f);
    color6 = uvec4(1.0f, 1.0f, 0.0235294f , 1.0f);
    color7 = uvec4(1.0f, 1.0f, 0.027451f , 1.0f);
}
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
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=0) out uvec4 color0;
layout (location=1) out uvec4 color1;
layout (location=2) out uvec4 color2;
layout (location=3) out uvec4 color3;
layout (location=4) out uvec4 color4;
layout (location=5) out uvec4 color5;
layout (location=6) out uvec4 color6;
layout (location=7) out uvec4 color7;
layout (location=8) out vec4 color8;
layout (location=9) out vec4 color9;
layout (location=10) out vec4 color10;
layout (location=11) out vec4 color11;
void main (void) {
    const uint layerIndex = 0u;
    color0 = uvec4(layerIndex, 255, 0, 255);
    color1 = uvec4(layerIndex, 255, 1, 255);
    color2 = uvec4(layerIndex, 255, 2, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color4 = uvec4(layerIndex, 255, 4, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color6 = uvec4(layerIndex, 255, 6, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
    color8 = uvec4(1.0f, 1.0f, 0.0313725f , 1.0f);
    color9 = uvec4(1.0f, 1.0f, 0.0352941f , 1.0f);
    color10 = uvec4(1.0f, 1.0f, 0.0392157f , 1.0f);
    color11 = uvec4(1.0f, 1.0f, 0.0431373f , 1.0f);
}
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
#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout (location=1) out uvec4 color1;
layout (location=3) out uvec4 color3;
layout (location=5) out uvec4 color5;
layout (location=7) out uvec4 color7;
layout (location=8) out vec4 color8;
layout (location=9) out vec4 color9;
layout (location=10) out vec4 color10;
layout (location=11) out vec4 color11;
void main (void) {
    const uint layerIndex = 0u;
    color1 = uvec4(layerIndex, 255, 1, 255);
    color3 = uvec4(layerIndex, 255, 3, 255);
    color5 = uvec4(layerIndex, 255, 5, 255);
    color7 = uvec4(layerIndex, 255, 7, 255);
    color8 = uvec4(1.0f, 1.0f, 0.0313725f , 1.0f);
    color9 = uvec4(1.0f, 1.0f, 0.0352941f , 1.0f);
    color10 = uvec4(1.0f, 1.0f, 0.0392157f , 1.0f);
    color11 = uvec4(1.0f, 1.0f, 0.0431373f , 1.0f);
}
