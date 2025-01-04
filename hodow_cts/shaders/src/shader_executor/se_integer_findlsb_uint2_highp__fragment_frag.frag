#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	lowp ivec2 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
