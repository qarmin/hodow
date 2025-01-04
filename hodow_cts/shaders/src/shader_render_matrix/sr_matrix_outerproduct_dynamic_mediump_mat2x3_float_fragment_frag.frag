#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump vec2 u_in1; };

void main (void)
{
    mediump mat2x3 res = outerProduct(v_coords, u_in1);
    dEQP_FragColor = vec4(res[0] + res[1], 1.0);
}
