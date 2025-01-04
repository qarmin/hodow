#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x4 v_mat3x4;
layout(location = 4) in highp float v_coords;

void main (void)
{
    highp mat3x4 res = v_mat3x4 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
