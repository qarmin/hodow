#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_x;
layout(location = 2) in highp ivec3 a_y;
layout(location = 0) flat out highp ivec3 vtx_out_msb;
layout(location = 1) flat out highp ivec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 x = a_x;
	highp ivec3 y = a_y;
	highp ivec3 msb;
	highp ivec3 lsb;
	imulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
