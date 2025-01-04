#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out ivec2 o_color;

void main(void)
{
    o_color = ivec2(in_color.rg * ivec2(125));
}
