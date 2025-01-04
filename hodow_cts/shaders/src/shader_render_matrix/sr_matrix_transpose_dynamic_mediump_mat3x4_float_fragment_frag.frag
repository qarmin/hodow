#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat3x4 v_mat3x4;

void main (void)
{
    mediump mat4x3 res = transpose(v_mat3x4);
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
