#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out ${color_type} o_color;

void main(void)
{
    o_color = ${color_type}(${swizzle});
}
