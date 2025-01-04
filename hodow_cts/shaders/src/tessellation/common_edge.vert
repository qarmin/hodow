#version 310 es

layout(location = 0) in highp vec2  in_v_position;
layout(location = 1) in highp float in_v_tessParam;

layout(location = 0) out highp vec2  in_tc_position;
layout(location = 1) out highp float in_tc_tessParam;

void main (void)
{
    in_tc_position = in_v_position;
    in_tc_tessParam = in_v_tessParam;
}
