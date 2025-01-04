#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { mediump mat3x2 u_in0; };

void main (void)
{
    mediump vec2 res = u_in0 * v_coords;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
