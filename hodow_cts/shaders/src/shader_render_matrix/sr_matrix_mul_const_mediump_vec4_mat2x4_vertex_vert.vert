#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
