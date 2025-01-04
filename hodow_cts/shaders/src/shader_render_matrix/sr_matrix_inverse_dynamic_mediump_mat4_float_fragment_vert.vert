#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4 a_mat4;
layout(location = 1) out mediump mat4 v_mat4;

void main (void)
{
    gl_Position = a_position;
    v_mat4 = a_mat4;
}
