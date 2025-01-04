#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    mediump float res = determinant(a_mat2);
    v_color = vec4(res, res, res, 1.0);
}
