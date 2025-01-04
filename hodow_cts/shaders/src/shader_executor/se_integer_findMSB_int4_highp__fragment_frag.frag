#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	lowp ivec4 msb;
	msb = findMSB(value);
	o_msb = msb;
}
