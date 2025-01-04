#version 450
layout(location = 0) flat in highp uvec2 vtx_out_value;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	highp uvec2 value = vtx_out_value;
	mediump ivec2 count;
	count = bitCount(value);
	o_count = count;
}
