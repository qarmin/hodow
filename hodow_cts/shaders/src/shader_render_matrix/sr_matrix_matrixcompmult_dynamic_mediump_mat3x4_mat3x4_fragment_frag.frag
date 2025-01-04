#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat3x4 u_in1; };

void main (void)
{
    mediump mat3x4 res = matrixCompMult(v_mat3x4, u_in1);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
