#version 310 es

layout(location = 0) in  highp   vec4 v_fragment_color;
layout(location = 0) out mediump vec4 fragColor;
void main (void)
{
    fragColor = v_fragment_color;
}
