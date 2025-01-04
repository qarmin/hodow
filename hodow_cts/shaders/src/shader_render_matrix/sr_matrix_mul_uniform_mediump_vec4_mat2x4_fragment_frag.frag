#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec4 v_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat2x4 u_in1; };

void main (void)
{
    mediump vec2 res = v_coords * u_in1;
    dEQP_FragColor = vec4(res.x, res.y, res.x, 1.0);
}
