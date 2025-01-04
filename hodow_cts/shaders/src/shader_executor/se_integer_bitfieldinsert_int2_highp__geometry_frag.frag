#version 450
layout(location = 0) flat in highp ivec2 geom_out_result;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
