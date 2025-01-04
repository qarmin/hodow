#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 1) out highp vec3 v_coords;
layout(location = 5) in highp mat3 a_mat3;
layout(location = 2) out highp mat3 v_mat3;

void main (void)
{
    gl_Position = a_position;
    v_coords = a_coords;
    v_mat3 = a_mat3;
}
