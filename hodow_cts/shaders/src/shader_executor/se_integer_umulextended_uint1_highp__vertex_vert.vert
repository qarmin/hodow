#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_x;
layout(location = 2) in highp uint a_y;
layout(location = 0) flat out highp uint vtx_out_msb;
layout(location = 1) flat out highp uint vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint x = a_x;
	highp uint y = a_y;
	highp uint msb;
	highp uint lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
