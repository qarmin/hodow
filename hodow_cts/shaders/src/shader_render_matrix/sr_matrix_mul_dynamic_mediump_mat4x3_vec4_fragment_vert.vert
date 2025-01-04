#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in mediump mat4x3 a_mat4x3;
layout(location = 1) out mediump mat4x3 v_mat4x3;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 5) out mediump vec4 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat4x3 = a_mat4x3;
    v_coords = a_coords;
}
