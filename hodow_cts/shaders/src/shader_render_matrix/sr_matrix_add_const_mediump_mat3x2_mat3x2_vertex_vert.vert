#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    gl_Position = a_position;
    mediump mat3x2 res = in0 + in1;
    v_color = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
