#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;

void main (void)
{
    mediump mat3x4 tmpValue = v_mat3x4;
    mediump mat3x4 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw + tmpValue[2].zwx, 0.0);
}
