#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_x;
layout(location = 1) flat in mediump uvec2 vtx_out_y;
layout(location = 0) out mediump uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	mediump uvec2 x = vtx_out_x;
	mediump uvec2 y = vtx_out_y;
	mediump uvec2 diff;
	lowp uvec2 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
