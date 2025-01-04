#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	highp uvec4 result;
	result = bitfieldReverse(value);
	o_result = result;
}
