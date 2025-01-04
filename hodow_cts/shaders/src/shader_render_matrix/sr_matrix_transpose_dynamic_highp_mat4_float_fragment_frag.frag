#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;

void main (void)
{
    highp mat4 res = transpose(v_mat4);
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
