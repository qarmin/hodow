#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x2 v_mat3x2;

void main (void)
{
    mediump mat2x3 res = transpose(v_mat3x2);
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
