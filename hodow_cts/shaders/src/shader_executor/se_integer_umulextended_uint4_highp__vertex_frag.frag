#version 450
layout(location = 0) flat in highp uvec4 vtx_out_msb;
layout(location = 1) flat in highp uvec4 vtx_out_lsb;
layout(location = 0) out highp uvec4 o_msb;
layout(location = 1) out highp uvec4 o_lsb;

void main (void)
{
	o_msb = vtx_out_msb;
	o_lsb = vtx_out_lsb;
}
