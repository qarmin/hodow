#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(location = 4) in mediump float v_coords;

void main (void)
{
    mediump mat3 res = v_mat3 + v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
