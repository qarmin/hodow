#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    mediump mat2x4 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0].xyz + res[1].yzw, 1.0);
}
