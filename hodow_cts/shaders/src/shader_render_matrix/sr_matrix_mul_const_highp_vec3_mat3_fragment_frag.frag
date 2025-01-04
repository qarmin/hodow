#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
const highp mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    highp vec3 res = v_coords * in1;
    dEQP_FragColor = vec4(res, 1.0);
}
