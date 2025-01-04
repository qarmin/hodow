#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in mediump mat2x4 a_mat2x4;

void main (void)
{
    gl_Position = a_position;
    mediump mat2x4 tmpValue = a_mat2x4;
    mediump mat2x4 res = tmpValue++;
    v_color = vec4(res[0].xyz + res[1].yzw, 1.0) + vec4(tmpValue[0].xyz + tmpValue[1].yzw, 0.0);
}
