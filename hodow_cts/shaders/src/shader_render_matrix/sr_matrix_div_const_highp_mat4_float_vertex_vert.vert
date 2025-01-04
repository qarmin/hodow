#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat4 in0 = mat4(0.3, -0.4, -0.9, -0.3, 0.9, -0.6, -0.1, -0.9, -0.2, 0.6, 0.3, 1.0, 1.0, -1.0, -0.2, 0.1);
layout(std140, set = 0, binding = 0) uniform buffer1 { highp float u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 / u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
