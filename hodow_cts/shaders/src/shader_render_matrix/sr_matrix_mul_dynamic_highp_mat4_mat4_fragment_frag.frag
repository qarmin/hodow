#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat4 v_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat4 u_in1; };

void main (void)
{
    highp mat4 res = v_mat4 * u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
