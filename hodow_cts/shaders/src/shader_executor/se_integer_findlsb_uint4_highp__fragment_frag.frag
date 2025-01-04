#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	lowp ivec4 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
