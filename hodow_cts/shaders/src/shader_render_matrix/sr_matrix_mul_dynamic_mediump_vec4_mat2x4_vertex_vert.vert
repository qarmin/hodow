#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
layout(location = 5) in mediump mat2x4 a_mat2x4;

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * a_mat2x4;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
