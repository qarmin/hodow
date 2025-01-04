#version 310 es
layout(location = 0) out mediump vec4 dEQP_FragColor;
layout(location = 1) in mediump vec3 v_coords;
const mediump mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    mediump vec4 res = v_coords * in1;
    dEQP_FragColor = vec4(res.x, res.y, res.z+res.w, 1.0);
}
