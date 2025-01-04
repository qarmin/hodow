#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
const highp mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);

void main (void)
{
    highp mat2x4 res = in0 * v_coords;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
