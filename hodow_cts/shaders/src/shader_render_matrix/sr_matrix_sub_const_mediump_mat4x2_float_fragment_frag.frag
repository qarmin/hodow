#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);

void main (void)
{
    mediump mat4x2 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
