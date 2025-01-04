#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(location = 1) out mediump mat3x2 v_mat3x2;

void main (void)
{
    gl_Position = a_position;
    v_mat3x2 = a_mat3x2;
}
