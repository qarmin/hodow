#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    highp mat2 res = in0 * in1;
    v_color = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
