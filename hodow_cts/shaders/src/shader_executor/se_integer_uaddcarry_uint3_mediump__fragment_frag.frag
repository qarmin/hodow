#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_x;
layout(location = 1) flat in mediump uvec3 vtx_out_y;
layout(location = 0) out mediump uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	mediump uvec3 x = vtx_out_x;
	mediump uvec3 y = vtx_out_y;
	mediump uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	o_sum = sum;
	o_carry = carry;
}
