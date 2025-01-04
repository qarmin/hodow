#version 450
layout(location = 0) flat in mediump uvec2 geom_out_extracted;
layout(location = 0) out mediump uvec2 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
