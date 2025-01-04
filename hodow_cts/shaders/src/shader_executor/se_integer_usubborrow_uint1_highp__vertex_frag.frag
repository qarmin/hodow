#version 450
layout(location = 0) flat in highp uint vtx_out_diff;
layout(location = 1) flat in lowp uint vtx_out_carry;
layout(location = 0) out highp uint o_diff;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_diff = vtx_out_diff;
	o_carry = vtx_out_carry;
}
