#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat3x2 v_mat3x2;
layout(location = 4) in highp vec3 v_coords;

void main (void)
{
    highp vec2 res = v_mat3x2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
