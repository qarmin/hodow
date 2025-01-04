#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
const highp mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    highp mat4x2 res = in0 * in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
