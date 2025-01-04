#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 1) in highp vec3 a_coords;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp vec4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = outerProduct(a_coords, u_in1);
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
