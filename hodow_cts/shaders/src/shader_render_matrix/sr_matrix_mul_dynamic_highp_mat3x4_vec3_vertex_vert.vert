#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3x4 a_mat3x4;
layout(location = 1) in highp vec3 a_coords;

void main (void)
{
    gl_Position = a_position;
    highp vec4 res = a_mat3x4 * a_coords;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
