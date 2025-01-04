#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
const highp mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    highp vec2 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
