#version 450
layout(location = 0) flat in highp ivec3 vtx_out_extracted;
layout(location = 0) out highp ivec3 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
