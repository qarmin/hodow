#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump vec2 res = a_coords * u_in1;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
