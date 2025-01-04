#version 310 es
layout(location = 0) out lowp vec4 o_color;
void main (void)
{
    o_color = vec4(gl_PointCoord, 0.0, 1.0);
}
