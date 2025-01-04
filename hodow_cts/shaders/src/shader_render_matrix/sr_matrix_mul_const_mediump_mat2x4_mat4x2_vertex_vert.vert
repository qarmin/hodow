#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    mediump mat4 res = in0 * in1;
    v_color = vec4(res[0].xyz+res[1].yzw+res[2].zwx+res[3].wxy, 1.0);
}
