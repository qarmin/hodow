#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;
layout(std140, set = 0, binding = 0) uniform buffer1 { highp mat3 u_in1; };

void main (void)
{
    gl_Position = a_position;
    highp mat3 res = a_mat3;
    res += u_in1;
    v_color = vec4(res[0] + res[1] + res[2], 1.0);
}
