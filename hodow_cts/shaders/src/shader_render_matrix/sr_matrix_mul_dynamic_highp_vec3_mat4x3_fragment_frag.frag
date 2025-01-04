#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp vec3 v_coords;
layout(location = 2) in highp mat4x3 v_mat4x3;

void main (void)
{
    highp vec4 res = v_coords * v_mat4x3;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
