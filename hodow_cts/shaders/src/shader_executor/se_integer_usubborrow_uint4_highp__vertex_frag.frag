#version 450
layout(location = 0) flat in highp uvec4 vtx_out_diff;
layout(location = 1) flat in lowp uvec4 vtx_out_carry;
layout(location = 0) out highp uvec4 o_diff;
layout(location = 1) out lowp uvec4 o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
