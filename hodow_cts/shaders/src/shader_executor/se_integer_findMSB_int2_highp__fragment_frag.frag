#version 450
layout(location = 0) flat in highp ivec2 vtx_out_value;
layout(location = 0) out lowp ivec2 o_msb;

void main (void)
{
	highp ivec2 value = vtx_out_value;
	lowp ivec2 msb;
	msb = findMSB(value);
	o_msb = msb;
}
