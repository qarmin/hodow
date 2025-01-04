#version 450
layout(location = 0) flat in highp ivec2 vtx_out_msb;
layout(location = 1) flat in highp ivec2 vtx_out_lsb;
layout(location = 0) out highp ivec2 o_msb;
layout(location = 1) out highp ivec2 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
