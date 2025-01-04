#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec2 a_x;
layout(location = 2) in highp ivec2 a_y;
layout(location = 0) flat out highp ivec2 vtx_out_msb;
layout(location = 1) flat out highp ivec2 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec2 x = a_x;
	highp ivec2 y = a_y;
	highp ivec2 msb;
	highp ivec2 lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
