#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x3 a_mat2x3;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x3 tmpValue = a_mat2x3;
    mediump mat2x3 res = tmpValue--;
    v_color = vec4(res[0] + res[1], 1.0) + vec4(tmpValue[0] + tmpValue[1], 0.0);
}
