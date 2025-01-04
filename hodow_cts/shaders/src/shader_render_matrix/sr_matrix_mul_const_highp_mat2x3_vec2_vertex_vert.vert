#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec2 a_coords;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);

void main (void)
{
    gl_Position = a_position;
    highp vec3 res = in0 * a_coords;
    v_color = vec4(res, 1.0);
}
