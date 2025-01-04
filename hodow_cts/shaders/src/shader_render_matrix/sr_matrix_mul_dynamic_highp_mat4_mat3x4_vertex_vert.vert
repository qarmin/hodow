#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3x4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3x4 res = a_mat4 * u_in1;
    v_color = vec4(res[0].xyz + res[1].yzw + res[2].zwx, 1.0);
}
