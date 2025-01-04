#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
const mediump mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    mediump vec2 res = in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
