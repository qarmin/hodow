#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const highp mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const highp mat4x2 in1 = mat4x2(1.0, 0.8, 0.1, -1.2, -1.1, -1.1, 0.6, 0.7);

void main (void)
{
    gl_Position = a_position;
    highp mat4x3 res = in0 * in1;
    v_color = vec4(res[0] + res[1] + res[2] + res[3], 1.0);
}
