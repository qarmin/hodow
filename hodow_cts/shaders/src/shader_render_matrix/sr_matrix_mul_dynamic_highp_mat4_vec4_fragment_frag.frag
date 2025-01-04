#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(location = 5) in highp vec4 v_coords;

void main (void)
{
    highp vec4 res = v_mat4 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
