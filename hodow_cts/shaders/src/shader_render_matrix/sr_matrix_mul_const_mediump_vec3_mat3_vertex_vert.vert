#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec3 a_coords;
const mediump mat3 in1 = mat3(-0.1, -0.1, -0.5, -0.1, -0.2, 0.1, 0.1, 1.0, -0.4);

void main (void)
{
    gl_Position = a_position;
    mediump vec3 res = a_coords * in1;
    v_color = vec4(res, 1.0);
}
