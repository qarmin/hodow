#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec2 v_coords;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    mediump vec3 res = in0 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
