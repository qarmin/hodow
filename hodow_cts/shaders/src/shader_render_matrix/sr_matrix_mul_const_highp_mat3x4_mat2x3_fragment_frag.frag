#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    highp mat2x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
