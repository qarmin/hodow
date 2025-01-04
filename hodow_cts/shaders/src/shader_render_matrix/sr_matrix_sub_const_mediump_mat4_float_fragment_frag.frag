#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump float v_coords;
const mediump mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);

void main (void)
{
    mediump mat4 res = in0 - v_coords;
    dEQP_FragColor = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
