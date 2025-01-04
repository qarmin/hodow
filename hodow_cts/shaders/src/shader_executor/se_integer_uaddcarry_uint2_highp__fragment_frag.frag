#version 450
layout(location = 0) flat in highp uvec2 vtx_out_x;
layout(location = 1) flat in highp uvec2 vtx_out_y;
layout(location = 0) out highp uvec2 o_sum;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	highp uvec2 x = vtx_out_x;
	highp uvec2 y = vtx_out_y;
	highp uvec2 sum;
	lowp uvec2 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
