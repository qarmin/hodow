#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat2x3 a_mat2x3;
layout(location = 1) out highp mat2x3 v_mat2x3;
layout(location = 1) in highp float a_coords;
layout(location = 3) out highp float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2x3 = a_mat2x3;
    v_coords = a_coords;
}
