#version 310 es
layout(location = 0) in highp vec4 a_position;
layout(location = 4) in highp vec4 a_in0;
layout(location = 5) in highp vec4 a_in1;
layout(location = 1) out highp vec4 v_in0;
layout(location = 2) out highp vec4 v_in1;

void main()
{
    gl_Position = a_position;
    v_in0 = a_in0;
    v_in1 = a_in1;
}
