#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec4 a_coords;
const mediump mat4 in1 = mat4(0.4, -0.4, 0.7, 0.2, -0.7, -0.8, -1.0, 0.6, -0.8, 0.6, 0.1, 0.4, 0.7, -0.3, -0.3, -1.0);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
