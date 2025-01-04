#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;

void main (void)
{
    gl_Position = a_position;
    highp float res = determinant(a_mat4);
    v_color = vec4(res, res, res, 1.0);
}
