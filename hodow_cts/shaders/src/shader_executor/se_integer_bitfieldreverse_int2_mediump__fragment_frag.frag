#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_value;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	mediump ivec2 value = vtx_out_value;
	highp ivec2 result;
	result = bitfieldReverse(value);
	o_result = result;
}
