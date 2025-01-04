#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat2x4 v_mat2x4;
layout(location = 3) in mediump vec2 v_coords;

void main (void)
{
    mediump vec4 res = v_mat2x4 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
