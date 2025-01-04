#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
const highp mat3x2 in0 = mat3x2(0.8, 1.0, -0.3, 1.2, 0.3, -1.2);

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
