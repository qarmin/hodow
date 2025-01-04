#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const mediump mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    mediump mat2x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
