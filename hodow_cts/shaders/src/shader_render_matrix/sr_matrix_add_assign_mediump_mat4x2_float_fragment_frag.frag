#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x2 u_in1; };

void main (void)
{
    mediump mat4x2 res = v_mat4x2;
    res += u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
