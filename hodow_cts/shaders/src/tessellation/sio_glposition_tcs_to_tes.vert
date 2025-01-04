#version 310 es

layout(location = 0) in  highp vec4 in_v_attr;
layout(location = 0) out highp vec4 in_tc_attr;

void main (void)
{
    in_tc_attr = in_v_attr;
}
