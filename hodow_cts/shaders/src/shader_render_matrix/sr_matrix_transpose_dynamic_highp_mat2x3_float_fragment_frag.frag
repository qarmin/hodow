#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x3 v_mat2x3;

void main (void)
{
    highp mat3x2 res = transpose(v_mat2x3);
    dEQP_FragColor = vec4(res[0][0]+res[0][1], res[1][0]+res[1][1], res[2][0]+res[2][1], 1.0);
}
