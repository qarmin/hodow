#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(location = 2) in mediump mat3x4 v_mat3x4;

void main (void)
{
    mediump vec3 res = v_coords * v_mat3x4;
    dEQP_FragColor = vec4(res, 1.0);
}
