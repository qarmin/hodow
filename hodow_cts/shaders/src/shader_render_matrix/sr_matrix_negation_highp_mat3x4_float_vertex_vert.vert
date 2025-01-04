#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = -a_mat3x4;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
