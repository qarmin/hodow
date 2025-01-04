#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = +a_mat2;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
