#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);

void main (void)
{
    mediump mat3x4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
