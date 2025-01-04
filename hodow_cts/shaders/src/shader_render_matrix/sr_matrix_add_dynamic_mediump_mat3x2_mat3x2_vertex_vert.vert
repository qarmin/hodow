#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat3x2 a_mat3x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x2 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = a_mat3x2 + u_in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
