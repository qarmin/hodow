#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;

void main (void)
{
    mediump mat2x3 tmpValue = v_mat2x3;
    mediump mat2x3 res = tmpValue--;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
