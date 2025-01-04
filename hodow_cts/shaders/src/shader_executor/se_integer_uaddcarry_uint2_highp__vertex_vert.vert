#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec2 a_x;
layout(location = 2) in highp uvec2 a_y;
layout(location = 0) flat out highp uvec2 vtx_out_sum;
layout(location = 1) flat out lowp uvec2 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 x = a_x;
	highp uvec2 y = a_y;
	highp uvec2 sum;
	lowp uvec2 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
