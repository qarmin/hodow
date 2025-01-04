#version 450
layout(location = 0) flat in mediump int vtx_out_count;
layout(location = 0) out mediump int o_count;

void main (void)
{
	o_count = vtx_out_count;
}
