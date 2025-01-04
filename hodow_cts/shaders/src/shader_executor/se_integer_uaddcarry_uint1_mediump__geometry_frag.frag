#version 450
layout(location = 0) flat in mediump uint geom_out_sum;
layout(location = 1) flat in lowp uint geom_out_carry;
layout(location = 0) out mediump uint o_sum;
layout(location = 1) out lowp uint o_carry;

void main (void)
{
	o_sum = geom_out_sum;
	o_carry = geom_out_carry;
}
