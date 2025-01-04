#version 450
layout(location = 0) flat in highp uvec3 vtx_out_value;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	highp uvec3 value = vtx_out_value;
	highp uvec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
