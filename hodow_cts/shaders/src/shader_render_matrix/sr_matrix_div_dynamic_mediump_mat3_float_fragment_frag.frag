#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3 v_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat3 res = v_mat3 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
