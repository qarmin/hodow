#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
const mediump mat2x3 in1 = mat2x3(1.1, 0.8, 0.7, 0.6, 1.0, 0.1);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = in0 - in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
