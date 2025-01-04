#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_extracted;
layout(location = 0) out mediump uvec4 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
