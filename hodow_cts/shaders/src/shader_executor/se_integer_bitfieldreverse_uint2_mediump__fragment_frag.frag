#version 450
layout(location = 0) flat in mediump uvec2 vtx_out_value;
layout(location = 0) out highp uvec2 o_result;

void main (void)
{
	mediump uvec2 value = vtx_out_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
