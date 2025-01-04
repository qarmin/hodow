#version 450
layout(location = 0) flat in mediump int geom_out_count;
layout(location = 0) out mediump int o_count;

void main (void)
{
	o_count = geom_out_count;
}
