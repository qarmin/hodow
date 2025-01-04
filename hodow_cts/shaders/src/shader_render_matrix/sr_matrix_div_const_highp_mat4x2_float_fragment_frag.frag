#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x2 in0 = mat4x2(-0.2, 1.2, 0.5, -0.5, 0.0, 0.3, -1.0, -0.9);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4x2 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0][0]+res[0][1]+res[3][0], res[1][0]+res[1][1]+res[3][1], res[2][0]+res[2][1], 1.0);
}
