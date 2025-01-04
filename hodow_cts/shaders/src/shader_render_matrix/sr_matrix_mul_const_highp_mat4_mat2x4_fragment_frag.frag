#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const highp mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    highp mat2x4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
