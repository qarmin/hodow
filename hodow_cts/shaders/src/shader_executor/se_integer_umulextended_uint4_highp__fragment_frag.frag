#version 450
layout(location = 0) flat in highp uvec4 vtx_out_x;
layout(location = 1) flat in highp uvec4 vtx_out_y;
layout(location = 0) out highp uvec4 o_msb;
layout(location = 1) out highp uvec4 o_lsb;

void main (void)
{
	highp uvec4 x = vtx_out_x;
	highp uvec4 y = vtx_out_y;
	highp uvec4 msb;
	highp uvec4 lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
