#version 450
layout(location = 0) out highp vec4 o_color;
void main (void)
{
    o_color = vec4(0.1, 0.2, 0.3, 1.0);
    if (gl_FrontFacing)
    o_color += vec4(0.3, 0.2, 0.1, 0.0);
    }
