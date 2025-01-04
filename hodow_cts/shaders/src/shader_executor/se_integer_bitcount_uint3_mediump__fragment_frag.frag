#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_value;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	mediump uvec3 value = vtx_out_value;
	mediump ivec3 count;
	count = bitCount(value);
	o_count = count;
}
