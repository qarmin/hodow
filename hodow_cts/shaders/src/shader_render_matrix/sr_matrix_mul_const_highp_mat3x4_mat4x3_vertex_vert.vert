#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat3x4 in0 = mat3x4(0.6, 0.9, 1.1, -0.2, -0.4, 0.8, 0.3, 0.0, 1.2, 0.4, 0.5, 1.1);
const highp mat4x3 in1 = mat4x3(0.5, 1.1, -0.2, 0.7, 0.1, -0.2, 0.7, 1.0, -0.3, 1.2, -1.0, -0.5);

void main (void)
{
    gl_Position = a_position;
    highp mat4 res = in0 * in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
