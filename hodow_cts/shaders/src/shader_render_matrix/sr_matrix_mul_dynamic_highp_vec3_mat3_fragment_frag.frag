#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
layout(location = 2) in highp mat3 v_mat3;

void main (void)
{
    highp vec3 res = v_coords * v_mat3;
    dEQP_FragColor = vec4(res, 1.0);
}
