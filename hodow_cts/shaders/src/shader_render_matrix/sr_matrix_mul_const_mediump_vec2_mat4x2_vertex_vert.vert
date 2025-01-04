#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in mediump vec2 a_coords;
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump vec4 res = a_coords * in1;
    v_color = vec4(res.x, res.y, res.z+res.w, 1.0);
}
