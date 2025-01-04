#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    mediump vec2 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
