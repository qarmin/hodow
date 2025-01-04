#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_sum;
layout(location = 1) flat in lowp uvec3 vtx_out_carry;
layout(location = 0) out mediump uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_sum = vtx_out_sum;
	o_carry = vtx_out_carry;
}
