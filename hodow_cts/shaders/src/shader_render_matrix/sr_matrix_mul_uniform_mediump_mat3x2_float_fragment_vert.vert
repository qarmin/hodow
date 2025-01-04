#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump float a_coords;
layout(location = 1) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
