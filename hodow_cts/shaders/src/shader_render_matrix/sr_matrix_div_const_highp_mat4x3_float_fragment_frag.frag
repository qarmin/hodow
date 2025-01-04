#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    highp mat4x3 res = in0 / u_in1;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
