#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump mat2x4 v_mat2x4;

void main (void)
{
    mediump vec2 res = v_coords * v_mat2x4;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
