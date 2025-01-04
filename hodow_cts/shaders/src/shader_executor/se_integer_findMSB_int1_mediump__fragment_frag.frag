#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	mediump int value = vtx_out_value;
	lowp int msb;
	msb = findMSB(value);
	o_msb = msb;
}
