#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_x;
layout(location = 2) in highp uvec3 a_y;
layout(location = 0) flat out highp uvec3 vtx_out_diff;
layout(location = 1) flat out lowp uvec3 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 x = a_x;
	highp uvec3 y = a_y;
	highp uvec3 diff;
	lowp uvec3 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
