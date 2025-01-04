#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_x;
layout(location = 1) flat in mediump uvec4 vtx_out_y;
layout(location = 0) out mediump uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	mediump uvec4 x = vtx_out_x;
	mediump uvec4 y = vtx_out_y;
	mediump uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
