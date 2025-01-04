#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x4 a_mat3x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat4x3 res = transpose(a_mat3x4);
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
