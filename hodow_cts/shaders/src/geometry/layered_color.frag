#version 450

layout(location = 0) out vec4 o_color;
layout(location = 0) in  vec4 vert_color;

void main(void)
{
    o_color = vert_color;
}
