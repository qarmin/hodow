#version 310 es

layout(location = 0) in  highp vec2 in_v_position;
layout(location = 0) out highp vec2 in_tc_position;

void main (void)
{
    in_tc_position = in_v_position;
}
