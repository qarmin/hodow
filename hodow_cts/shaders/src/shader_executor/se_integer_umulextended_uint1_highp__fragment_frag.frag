#version 450
layout(location = 0) flat in highp uint vtx_out_x;
layout(location = 1) flat in highp uint vtx_out_y;
layout(location = 0) out highp uint o_msb;
layout(location = 1) out highp uint o_lsb;

void main (void)
{
	highp uint x = vtx_out_x;
	highp uint y = vtx_out_y;
	highp uint msb;
	highp uint lsb;
	umulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
