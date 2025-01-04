#version 450
layout(location = 0) flat in mediump uint geom_out_extracted;
layout(location = 0) out mediump uint o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
