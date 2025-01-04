#version 450
layout(location = 0) flat in highp int vtx_out_x;
layout(location = 1) flat in highp int vtx_out_y;
layout(location = 0) out highp int o_msb;
layout(location = 1) out highp int o_lsb;

void main (void)
{
	highp int x = vtx_out_x;
	highp int y = vtx_out_y;
	highp int msb;
	highp int lsb;
	imulExtended(x, y, msb, lsb);
	o_msb = msb;
	o_lsb = lsb;
}
