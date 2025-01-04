#version 450
layout(location = 0) flat in mediump int vtx_out_value;
layout(location = 0) out highp int o_result;

void main (void)
{
	mediump int value = vtx_out_value;
	highp int result;
	result = bitfieldReverse(value);
	o_result = result;
}
