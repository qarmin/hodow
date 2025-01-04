#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    mediump mat4 res = in0 * in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
