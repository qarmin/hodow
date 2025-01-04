#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x4 in0 = mat2x4(-0.6, -0.6, -0.2, -0.1, -1.1, -0.6, -0.6, -0.1);
const mediump mat2 in1 = mat2(0.8, 0.5, 0.1, -0.9);

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 res = in0 * in1;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0);
}
