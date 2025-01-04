#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(location = 4) in mediump float v_coords;

void main (void)
{
    mediump mat3x4 res = v_mat3x4 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
