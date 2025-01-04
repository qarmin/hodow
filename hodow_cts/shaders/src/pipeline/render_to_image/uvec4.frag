#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out uvec4 o_color;

void main(void)
{
    o_color = uvec4(in_color * uvec4(125));
}
