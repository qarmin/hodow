#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
const highp mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    highp mat4x3 res = in0 - in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
