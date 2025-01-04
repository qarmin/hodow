#version 310 es

layout(location = 0) in  highp   float in_f_blue;
layout(location = 0) out mediump vec4  o_color;

void main (void)
{
    o_color = vec4(1.0, 0.0, in_f_blue, 1.0);
}
