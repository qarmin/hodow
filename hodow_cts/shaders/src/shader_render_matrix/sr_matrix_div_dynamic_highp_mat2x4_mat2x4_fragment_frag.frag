#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp mat2x4 v_mat2x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat2x4 u_in1; };

void main (void)
{
    highp mat2x4 res = v_mat2x4 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
