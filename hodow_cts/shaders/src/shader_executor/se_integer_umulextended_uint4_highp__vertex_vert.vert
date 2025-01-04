#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_x;
layout(location = 2) in highp uvec4 a_y;
layout(location = 0) flat out highp uvec4 vtx_out_msb;
layout(location = 1) flat out highp uvec4 vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 x = a_x;
	highp uvec4 y = a_y;
	highp uvec4 msb;
	highp uvec4 lsb;
	umulExtended(x, y, msb, lsb);
	vtx_out_msb = msb;
	vtx_out_lsb = lsb;
}
