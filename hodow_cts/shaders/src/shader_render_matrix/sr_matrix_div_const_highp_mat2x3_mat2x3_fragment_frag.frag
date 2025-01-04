#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    highp mat2x3 res = in0 / in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
