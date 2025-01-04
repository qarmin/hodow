#version 450
layout(location = 0) flat in highp uint vtx_out_x;
layout(location = 1) flat in highp uint vtx_out_y;
layout(location = 0) out highp uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	highp uint x = vtx_out_x;
	highp uint y = vtx_out_y;
	highp uint diff;
	lowp uint carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
