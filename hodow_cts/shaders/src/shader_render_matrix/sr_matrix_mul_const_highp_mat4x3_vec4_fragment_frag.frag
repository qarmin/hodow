#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec4 v_coords;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    highp vec3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
