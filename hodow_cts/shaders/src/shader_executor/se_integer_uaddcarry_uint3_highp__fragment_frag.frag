#version 450
layout(location = 0) flat in highp uvec3 vtx_out_x;
layout(location = 1) flat in highp uvec3 vtx_out_y;
layout(location = 0) out highp uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	highp uvec3 x = vtx_out_x;
	highp uvec3 y = vtx_out_y;
	highp uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
