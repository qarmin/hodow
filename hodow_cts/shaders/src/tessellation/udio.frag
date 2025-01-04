#version 310 es

layout(location = 0) in  highp   vec4 in_f_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
