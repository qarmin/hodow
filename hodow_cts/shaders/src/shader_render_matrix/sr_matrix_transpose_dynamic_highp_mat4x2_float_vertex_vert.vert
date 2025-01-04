#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x2 a_mat4x2;

void main (void)
{
    gl_Position = a_position;
    highp mat2x4 res = transpose(a_mat4x2);
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
