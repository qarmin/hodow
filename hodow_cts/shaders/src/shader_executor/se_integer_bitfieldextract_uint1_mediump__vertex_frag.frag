#version 450
layout(location = 0) flat in mediump uint vtx_out_extracted;
layout(location = 0) out mediump uint o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
