#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_value;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	mediump ivec3 value = vtx_out_value;
	lowp ivec3 lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
