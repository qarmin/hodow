#version 450
layout(location = 0) flat in highp ivec2 vtx_out_x;
layout(location = 1) flat in highp ivec2 vtx_out_y;
layout(location = 0) out highp ivec2 o_msb;
layout(location = 1) out highp ivec2 o_lsb;

void main (void)
{
	highp ivec2 x = vtx_out_x;
	highp ivec2 y = vtx_out_y;
	highp ivec2 msb;
	highp ivec2 lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
