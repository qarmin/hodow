#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_x;
layout(location = 2) in highp uvec3 a_y;
layout(location = 0) flat out highp uvec3 vtx_out_msb;
layout(location = 1) flat out highp uvec3 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 x = a_x;
	highp uvec3 y = a_y;
	highp uvec3 msb;
	highp uvec3 lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
