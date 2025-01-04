#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 1) out mediump vec4 v_coords;
layout(location = 5) in mediump mat3x4 a_mat3x4;
layout(location = 2) out mediump mat3x4 v_mat3x4;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat3x4 = a_mat3x4;
}
