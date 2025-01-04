#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = transpose(a_mat4x3);
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
