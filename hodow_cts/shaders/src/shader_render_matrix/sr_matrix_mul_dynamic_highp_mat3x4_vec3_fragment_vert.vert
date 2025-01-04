#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) out highp mat3x4 v_mat3x4;
layout(location = 1) in highp vec3 a_coords;
layout(location = 4) out highp vec3 v_coords;

void main (void)
{
    gl_Position = a_position;
    v_mat3x4 = a_mat3x4;
    v_coords = a_coords;
}
