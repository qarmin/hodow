#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_x;
layout(location = 2) in highp int a_y;
layout(location = 0) flat out highp int vtx_out_msb;
layout(location = 1) flat out highp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int x = a_x;
	highp int y = a_y;
	highp int msb;
	highp int lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
