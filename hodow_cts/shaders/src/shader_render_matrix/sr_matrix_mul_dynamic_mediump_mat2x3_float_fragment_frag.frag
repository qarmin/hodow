#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x3 v_mat2x3;
layout(location = 3) in mediump float v_coords;

void main (void)
{
    mediump mat2x3 res = v_mat2x3 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
