#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	mediump ivec4 count;
	count = bitCount(value);
	o_count = count;
}
