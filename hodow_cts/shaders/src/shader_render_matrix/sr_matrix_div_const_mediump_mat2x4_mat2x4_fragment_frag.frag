#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    mediump mat2x4 res = in0 / in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
