#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(location = 3) in highp float v_coords;

void main (void)
{
    highp mat2x4 res = v_mat2x4 + v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
