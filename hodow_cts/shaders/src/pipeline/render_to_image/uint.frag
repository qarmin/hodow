#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uint o_color;

void main(void)
{
    o_color = uint(in_color.r * uint(125));
}
