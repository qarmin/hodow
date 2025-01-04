#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    mediump mat2 res = in0 / in1;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
