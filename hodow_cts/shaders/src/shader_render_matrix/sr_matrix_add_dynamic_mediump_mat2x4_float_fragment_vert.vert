#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2x4 a_mat2x4;
layout(location = 1) out mediump mat2x4 v_mat2x4;
layout(location = 1) in mediump float a_coords;
layout(location = 3) out mediump float v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat2x4 = a_mat2x4;
    v_coords = a_coords;
}
