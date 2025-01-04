#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4x3 v_mat4x3;

void main (void)
{
    highp mat3x4 res = transpose(v_mat4x3);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
