#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
const highp mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
