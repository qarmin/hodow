#version 450
layout(location = 0) flat in mediump uvec2 geom_out_result;
layout(location = 0) out mediump uvec2 o_result;

void main (void)
{
	o_result = geom_out_result;
}
