#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const mediump mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    mediump mat2x3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
