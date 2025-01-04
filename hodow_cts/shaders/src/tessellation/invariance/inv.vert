#version 310 es

layout(location = 0) in  highp float in_v_attr;
layout(location = 0) out highp float in_tc_attr;

void main (void)
{
    in_tc_attr = in_v_attr;
}
