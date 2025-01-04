#version 450

layout(location = 0) in flat vec4 in_color;
layout(location = 0) out vec4 o_color;

void main (void)
{
    o_color = vec4(in_color.rgb + vec3(0.0, 0.0, 0.5), 1.0);
}
