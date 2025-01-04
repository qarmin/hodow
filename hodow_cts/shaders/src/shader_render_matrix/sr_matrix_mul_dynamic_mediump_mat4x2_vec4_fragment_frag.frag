#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(location = 5) in mediump vec4 v_coords;

void main (void)
{
    mediump vec2 res = v_mat4x2 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
