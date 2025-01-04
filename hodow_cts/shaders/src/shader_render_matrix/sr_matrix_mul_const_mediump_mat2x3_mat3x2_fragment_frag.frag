#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const mediump mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    mediump mat3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
