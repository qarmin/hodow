#version 450

layout(location = 0) flat in  int  in_ndx;
layout(location = 0)      out vec4 o_color;

void main(void)
{
    if (in_ndx % 2 == 0)
        o_color = vec4(vec3(1.0), 1.0);
    else
        o_color = vec4(vec3(0.75), 1.0);
}
