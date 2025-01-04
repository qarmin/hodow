#version 310 es
layout(location = 0) out highp vec4 o_color;
void main (void)
{
       o_color = vec4(0.0, 1.0 / gl_FragCoord.w - 1.0, 0.0, 1.0);
}
