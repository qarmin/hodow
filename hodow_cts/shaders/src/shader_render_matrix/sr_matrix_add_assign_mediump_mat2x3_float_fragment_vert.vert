#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat2x3 a_mat2x3;
layout(location = 1) out mediump mat2x3 v_mat2x3;

void main (void)
{
    gl_Position = a_position;
    v_mat2x3 = a_mat2x3;
}
