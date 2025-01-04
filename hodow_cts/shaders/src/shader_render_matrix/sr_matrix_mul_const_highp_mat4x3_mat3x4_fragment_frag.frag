#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat3x4 in1 = mat3x4(-0.8, -1.1, -1.2, 0.1, 1.2, -0.9, 1.0, -0.7, -0.2, -0.5, 1.2, -0.5);

void main (void)
{
    highp mat3 res = in0 * in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
