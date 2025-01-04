#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 0) out highp uvec3 o_result;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	highp uvec3 result;
	result = bitfieldReverse(value);
	o_result = result;
}
