#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_coords;
layout(location = 1) out mediump vec2 v_coords;
layout(location = 5) in mediump mat4x2 a_mat4x2;
layout(location = 2) out mediump mat4x2 v_mat4x2;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat4x2 = a_mat4x2;
}
