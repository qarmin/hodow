#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat2 a_mat2;

void main (void)
{
    gl_Position = a_position;
    highp mat2 tmpValue = a_mat2;
    highp mat2 res = ++tmpValue;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
