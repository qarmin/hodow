#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 0) out highp ivec4 o_result;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	highp ivec4 result;
	result = bitfieldReverse(value);
	o_result = result;
}
