#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec2 v_coords;
const highp mat3x2 in1 = mat3x2(1.2, -0.8, -1.0, 1.1, 0.5, 0.3);

void main (void)
{
    highp vec3 res = v_coords * in1;
    dEQP_FragColor = vec4(res, 1.0);
}
