#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump mat4x3 v_mat4x3;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4x3 u_in1; };

void main (void)
{
    mediump mat4x3 res = v_mat4x3 + u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
