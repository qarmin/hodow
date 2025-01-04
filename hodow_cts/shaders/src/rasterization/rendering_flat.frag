#version 310 es
layout(location = 0) out highp vec4 fragColor;
layout(location = 0) flat in highp vec4 v_color;
void main ()
{
    fragColor = v_color;
}
