#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 0) out highp uint o_result;

void main (void)
{
	highp uint value = vtx_out_value;
	highp uint result;
	result = bitfieldReverse(value);
	o_result = result;
}
