#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump float res = determinant(v_mat2);
    dEQP_FragColor = vec4(res, res, res, 1.0);
}
