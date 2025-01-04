#version 450
layout(location = 0) flat in highp uvec3 geom_out_result;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	o_result = geom_out_result;
}
