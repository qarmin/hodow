#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat4 u_in0; };
layout(std140, set = 0, binding = 1) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    mediump mat4 res = u_in0 + u_in1;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
