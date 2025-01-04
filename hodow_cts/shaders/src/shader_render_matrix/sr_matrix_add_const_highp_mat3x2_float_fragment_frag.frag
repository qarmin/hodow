#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    highp mat3x2 res = in0 + v_coords;
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
