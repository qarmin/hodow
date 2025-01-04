#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
const highp mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    highp mat3 res = in0 + in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
