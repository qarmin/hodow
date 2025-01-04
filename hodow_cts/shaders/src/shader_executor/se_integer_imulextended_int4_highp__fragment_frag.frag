#version 450
layout(location = 0) flat in highp ivec4 vtx_out_x;
layout(location = 1) flat in highp ivec4 vtx_out_y;
layout(location = 0) out highp ivec4 o_msb;
layout(location = 1) out highp ivec4 o_lsb;

void main (void)
{
	highp ivec4 x = vtx_out_x;
	highp ivec4 y = vtx_out_y;
	highp ivec4 msb;
	highp ivec4 lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
