#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec4 a_x;
layout(location = 2) in highp uvec4 a_y;
layout(location = 0) flat out highp uvec4 vtx_out_diff;
layout(location = 1) flat out lowp uvec4 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec4 x = a_x;
	highp uvec4 y = a_y;
	highp uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
