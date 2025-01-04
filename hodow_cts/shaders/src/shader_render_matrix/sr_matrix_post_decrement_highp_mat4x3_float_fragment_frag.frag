#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;

void main (void)
{
    highp mat4x3 tmpValue = v_mat4x3;
    highp mat4x3 res = tmpValue--;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2] + tmpValue[3], 0.0);
}
