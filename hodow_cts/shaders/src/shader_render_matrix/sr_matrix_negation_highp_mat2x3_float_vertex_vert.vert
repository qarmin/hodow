#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    highp mat2x3 res = -a_mat2x3;
    v_color = vec4(res[0] + res[1], 1.0);
}
