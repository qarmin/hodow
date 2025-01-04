#version 450
layout(location = 0) flat in mediump uint vtx_out_x;
layout(location = 1) flat in mediump uint vtx_out_y;
layout(location = 0) out mediump uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	mediump uint x = vtx_out_x;
	mediump uint y = vtx_out_y;
	mediump uint diff;
	lowp uint carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
