#version 450
layout(location = 0) flat in highp uvec3 vtx_out_x;
layout(location = 1) flat in highp uvec3 vtx_out_y;
layout(location = 0) out highp uvec3 o_msb;
layout(location = 1) out highp uvec3 o_lsb;

void main (void)
{
	highp uvec3 x = vtx_out_x;
	highp uvec3 y = vtx_out_y;
	highp uvec3 msb;
	highp uvec3 lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
