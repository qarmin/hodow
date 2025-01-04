#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump mat2 res = in0 - in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
