#version 440

layout(location = 0) in highp vec4 a_color;
layout(location = 0) out highp vec4 o_color;

void main (void)
{
    o_color = a_color;
}
