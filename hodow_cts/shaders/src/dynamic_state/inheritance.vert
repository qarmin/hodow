#version 460

layout(location=0) in vec3 xyz;
layout(location=1) in int r8g8b8;
layout(location=2) in vec2 widthHeight;
layout(location=3) in int viewportIndex;

layout(location=0) flat out int o_r8g8b8;
layout(location=1) flat out vec2 o_widthHeight;
layout(location=2) flat out int o_viewportIndex;

void main()
{
    gl_Position     = vec4(xyz, 1.0);
    o_r8g8b8        = r8g8b8;
    o_widthHeight   = widthHeight;
    o_viewportIndex = viewportIndex;
}
