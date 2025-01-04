#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	highp uint value = vtx_out_value;
	lowp int lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
