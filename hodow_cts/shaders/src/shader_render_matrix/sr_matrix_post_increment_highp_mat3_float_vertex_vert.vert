#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 0) out mediump vec4 v_color;
layout(location = 4) in highp mat3 a_mat3;

void main (void)
{
    gl_Position = a_position;
    highp mat3 tmpValue = a_mat3;
    highp mat3 res = tmpValue++;
    v_color = vec4(res[0] + res[1] + res[2], 1.0) + vec4(tmpValue[0] + tmpValue[1] + tmpValue[2], 0.0);
}
