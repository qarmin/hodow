#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;

void main (void)
{
    highp float res = determinant(v_mat4);
    dEQP_FragColor = vec4(res, res, res, 1.0);
}
