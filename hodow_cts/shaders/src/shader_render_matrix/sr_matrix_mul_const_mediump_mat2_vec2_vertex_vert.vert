#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
