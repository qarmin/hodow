#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
const mediump mat2x3 in0 = mat2x3(-0.6, -0.7, -0.2, -0.1, -1.2, 0.0);
layout(std140, set = 0, binding = 0) uniform buffer1 { mediump float u_in1; };

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 res = in0 / u_in1;
    v_color = vec4(res[0] + res[1], 1.0);
}
