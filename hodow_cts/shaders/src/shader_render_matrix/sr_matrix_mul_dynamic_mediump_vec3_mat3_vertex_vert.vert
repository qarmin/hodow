#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
layout(location = 5) in mediump mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_coords * a_mat3;
    v_color = vec4(res, 1.0);
}
