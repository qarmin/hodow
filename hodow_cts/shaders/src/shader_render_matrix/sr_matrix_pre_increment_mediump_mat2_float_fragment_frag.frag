#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2 v_mat2;

void main (void)
{
    mediump mat2 tmpValue = v_mat2;
    mediump mat2 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0][0], res[1][0], res[0][1]+res[1][1], 1.0) + vec4(tmpValue[0][0], tmpValue[1][0], tmpValue[0][1]+tmpValue[1][1], 0.0);
}
