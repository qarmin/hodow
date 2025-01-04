#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat4 a_mat4;
layout(location = 1) in mediump float a_coords;

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = a_mat4 + a_coords;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
