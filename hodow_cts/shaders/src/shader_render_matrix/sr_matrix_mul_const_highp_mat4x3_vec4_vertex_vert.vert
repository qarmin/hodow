#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec4 a_coords;
const highp mat4x3 in0 = mat4x3(-0.9, 0.9, -0.1, 0.0, -0.1, 0.1, 0.6, -0.3, 1.0, 0.2, -0.7, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = in0 * a_coords;
    v_color = vec4(res, 1.0);
}
