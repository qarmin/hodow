#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
