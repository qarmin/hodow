#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer0 { highp mat3x2 u_in0; };

void main (void)
{
    gl_Position = a_position;
    highp vec2 res = u_in0 * a_coords;
    v_color = vec4(res.x, res.y, res.x, 1.0);
}
