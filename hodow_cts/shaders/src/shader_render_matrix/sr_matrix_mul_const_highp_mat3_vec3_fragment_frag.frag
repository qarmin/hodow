#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);

void main (void)
{
    highp vec3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
