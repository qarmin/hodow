#version 450
layout(location = 0) flat in highp uvec3 vtx_out_diff;
layout(location = 1) flat in lowp uvec3 vtx_out_carry;
layout(location = 0) out highp uvec3 o_diff;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
