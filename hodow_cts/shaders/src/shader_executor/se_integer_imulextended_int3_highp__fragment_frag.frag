#version 450
layout(location = 0) flat in highp ivec3 vtx_out_x;
layout(location = 1) flat in highp ivec3 vtx_out_y;
layout(location = 0) out highp ivec3 o_msb;
layout(location = 1) out highp ivec3 o_lsb;

void main (void)
{
	highp ivec3 x = vtx_out_x;
	highp ivec3 y = vtx_out_y;
	highp ivec3 msb;
	highp ivec3 lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
