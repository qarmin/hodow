#version 450

layout(location = 0) in  vec4 in_color;
layout(location = 0) out vec3 o_color;

void main(void)
{
    o_color = vec3(in_color.rgb);
}
