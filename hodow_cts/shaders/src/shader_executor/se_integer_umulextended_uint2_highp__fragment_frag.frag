#version 450
layout(location = 0) flat in highp uvec2 vtx_out_x;
layout(location = 1) flat in highp uvec2 vtx_out_y;
layout(location = 0) out highp uvec2 o_msb;
layout(location = 1) out highp uvec2 o_lsb;

void main (void)
{
	highp uvec2 x = vtx_out_x;
	highp uvec2 y = vtx_out_y;
	highp uvec2 msb;
	highp uvec2 lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
