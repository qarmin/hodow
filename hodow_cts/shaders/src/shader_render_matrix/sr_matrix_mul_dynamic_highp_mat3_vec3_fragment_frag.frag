#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3 v_mat3;
layout(location = 4) in highp vec3 v_coords;

void main (void)
{
    highp vec3 res = v_mat3 * v_coords;
    dEQP_FragColor = vec4(res, 1.0);
}
