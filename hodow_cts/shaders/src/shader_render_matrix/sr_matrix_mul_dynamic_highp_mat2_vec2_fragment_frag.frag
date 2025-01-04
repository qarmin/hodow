#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2 v_mat2;
layout(location = 3) in highp vec2 v_coords;

void main (void)
{
    highp vec2 res = v_mat2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
