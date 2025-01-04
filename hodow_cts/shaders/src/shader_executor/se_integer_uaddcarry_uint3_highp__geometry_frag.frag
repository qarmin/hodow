#version 450
layout(location = 0) flat in highp uvec3 geom_out_sum;
layout(location = 1) flat in lowp uvec3 geom_out_carry;
layout(location = 0) out highp uvec3 o_sum;
layout(location = 1) out lowp uvec3 o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
