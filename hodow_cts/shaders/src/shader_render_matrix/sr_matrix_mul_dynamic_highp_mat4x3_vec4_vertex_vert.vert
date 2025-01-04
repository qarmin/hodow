#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4x3 a_mat4x3;
layout(location = 1) in highp vec4 a_coords;

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = a_mat4x3 * a_coords;
    v_color = vec4(res, 1.0);
}
