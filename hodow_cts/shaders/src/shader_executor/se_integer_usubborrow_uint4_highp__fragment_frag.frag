#version 450
layout(location = 0) flat in highp uvec4 vtx_out_x;
layout(location = 1) flat in highp uvec4 vtx_out_y;
layout(location = 0) out highp uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	highp uvec4 x = vtx_out_x;
	highp uvec4 y = vtx_out_y;
	highp uvec4 diff;
	lowp uvec4 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
