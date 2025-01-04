#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in highp float v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3 u_in0; };

void main (void)
{
    highp mat3 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res[0] + res[1] + res[2], 1.0);
}
