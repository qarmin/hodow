#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;

void main (void)
{
    highp mat2x4 tmpValue = v_mat2x4;
    highp mat2x4 res = tmpValue++;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw, 0.0);
}
