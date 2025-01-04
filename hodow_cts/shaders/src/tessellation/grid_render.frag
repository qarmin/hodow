#version 310 es
layout(location = 0) flat in highp   vec4 v_color;
layout(location = 0) out     mediump vec4 fragColor;

void main (void)
{
    fragColor = v_color;
}
