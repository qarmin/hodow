#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
const highp mat2 in0 = mat2(-0.1, -0.2, 1.0, 0.0);

void main (void)
{
    highp vec2 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
