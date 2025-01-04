#version 450

layout(location = 0) out vec4 o_color0;
layout(location = 1) out vec4 o_color1;
layout(location = 2) out vec4 o_color2;

void main(void)
{
    o_color0 = vec4(1.0,  0.5, 0.25, 1.0);
    o_color2 = vec4(0.25, 0.5, 1.0,  1.0);
}
