#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_extracted;
layout(location = 0) out mediump uvec3 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
