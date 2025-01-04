#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
const highp mat2x4 in1 = mat2x4(-1.2, 0.7, 0.7, -0.4, -1.0, -1.0, 0.7, -0.3);

void main (void)
{
    highp vec2 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
