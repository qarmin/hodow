#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
const highp mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    highp vec4 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
