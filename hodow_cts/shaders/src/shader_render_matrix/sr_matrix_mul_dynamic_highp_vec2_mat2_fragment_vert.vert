#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 1) out highp vec2 v_coords;
layout(location = 5) in highp mat2 a_mat2;
layout(location = 2) out highp mat2 v_mat2;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat2 = a_mat2;
}
