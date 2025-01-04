#version 440

layout(location = 0) in highp vec4 vsColor;
layout(location = 0) out highp vec4 fsColor;

void main (void)
{
    fsColor     = vsColor;
}
