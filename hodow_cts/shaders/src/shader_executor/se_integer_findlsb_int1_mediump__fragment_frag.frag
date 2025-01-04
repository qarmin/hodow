#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	mediump int value = vtx_out_value;
	lowp int lsb;
	lsb = findLSB(value);
	o_lsb = lsb;
}
