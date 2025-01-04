#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump float a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4x2 res = u_in0 - a_coords;
    v_color = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
