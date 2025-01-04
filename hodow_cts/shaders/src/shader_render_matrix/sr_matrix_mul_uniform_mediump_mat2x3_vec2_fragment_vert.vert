#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_coords;
layout(location = 1) out mediump vec2 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
}
