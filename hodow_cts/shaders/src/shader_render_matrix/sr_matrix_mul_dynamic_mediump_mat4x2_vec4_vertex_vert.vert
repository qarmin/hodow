#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4x2 a_mat4x2;
layout(location = 1) in mediump vec4 a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_mat4x2 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
