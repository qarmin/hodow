#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
layout(location = 2) in highp mat2x4 v_mat2x4;

void main (void)
{
    highp vec2 res = v_coords * v_mat2x4;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
