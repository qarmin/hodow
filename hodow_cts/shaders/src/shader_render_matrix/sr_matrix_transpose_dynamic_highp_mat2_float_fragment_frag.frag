#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;

void main (void)
{
    highp mat2 res = transpose(v_mat2);
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0);
}
