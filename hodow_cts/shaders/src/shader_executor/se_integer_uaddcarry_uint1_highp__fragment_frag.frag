#version 450
layout(location = 0) flat in highp uint vtx_out_x;
layout(location = 1) flat in highp uint vtx_out_y;
layout(location = 0) out highp uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	highp uint x = vtx_out_x;
	highp uint y = vtx_out_y;
	highp uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
