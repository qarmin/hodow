#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    mediump mat2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
