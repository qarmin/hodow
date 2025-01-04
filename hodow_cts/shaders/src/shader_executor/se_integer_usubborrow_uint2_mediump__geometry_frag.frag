#version 450
layout(location = 0) flat in mediump uvec2 geom_out_diff;
layout(location = 1) flat in lowp uvec2 geom_out_carry;
layout(location = 0) out mediump uvec2 o_diff;
layout(location = 1) out lowp uvec2 o_carry;

void main (void)
{
	o_diff = geom_out_diff;
	o_carry = geom_out_carry;
}
