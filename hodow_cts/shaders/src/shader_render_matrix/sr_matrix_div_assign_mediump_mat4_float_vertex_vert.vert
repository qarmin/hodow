#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump mat4 u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4;
    res /= u_in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
