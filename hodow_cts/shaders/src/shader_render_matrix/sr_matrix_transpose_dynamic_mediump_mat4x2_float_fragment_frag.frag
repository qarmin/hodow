#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x2 v_mat4x2;

void main (void)
{
    mediump mat2x4 res = transpose(v_mat4x2);
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
