#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;

void main (void)
{
    mediump mat3 tmpValue = v_mat3;
    mediump mat3 res = ++tmpValue;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
