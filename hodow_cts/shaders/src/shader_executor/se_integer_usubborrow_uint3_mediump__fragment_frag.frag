#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_x;
layout(location = 1) flat in mediump uvec3 vtx_out_y;
layout(location = 0) out mediump uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	mediump uvec3 x = vtx_out_x;
	mediump uvec3 y = vtx_out_y;
	mediump uvec3 diff;
	lowp uvec3 carry;
	diff = usubBorrow(x, y, carry);
	o_diff = diff;
	o_carry = carry;
}
