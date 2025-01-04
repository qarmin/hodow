#version 450

layout(push_constant) uniform Color { vec4 color; } u_color;
layout(location = 0) out vec4 out_color;

void main(void)
{
    out_color = u_color.color;
}
