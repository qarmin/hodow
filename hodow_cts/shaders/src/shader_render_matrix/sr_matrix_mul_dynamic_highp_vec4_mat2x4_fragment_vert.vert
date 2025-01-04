#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_coords;
layout(location = 1) out highp vec4 v_coords;
layout(location = 5) in highp mat2x4 a_mat2x4;
layout(location = 2) out highp mat2x4 v_mat2x4;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat2x4 = a_mat2x4;
}
