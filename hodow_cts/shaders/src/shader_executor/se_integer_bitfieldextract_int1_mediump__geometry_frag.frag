#version 450
layout(location = 0) flat in mediump int geom_out_extracted;
layout(location = 0) out mediump int o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
