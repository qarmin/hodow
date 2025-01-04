#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3 in0 = mat3(-0.2, -1.0, 0.7, 1.1, 1.2, -0.2, 1.2, 0.5, 1.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = in0 / u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
