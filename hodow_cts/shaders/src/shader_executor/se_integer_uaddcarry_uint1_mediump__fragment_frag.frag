#version 450
layout(location = 0) flat in mediump uint vtx_out_x;
layout(location = 1) flat in mediump uint vtx_out_y;
layout(location = 0) out mediump uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	mediump uint x = vtx_out_x;
	mediump uint y = vtx_out_y;
	mediump uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
