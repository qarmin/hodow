#version 450
layout(location = 0) flat in highp int vtx_out_value;
layout(location = 0) out mediump int o_count;

void main (void)
{
	highp int value = vtx_out_value;
	mediump int count;
	count = bitCount(value);
	o_count = count;
}
