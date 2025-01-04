#version 450
layout(location = 0) flat in highp ivec3 vtx_out_value;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	highp ivec3 value = vtx_out_value;
	highp ivec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
