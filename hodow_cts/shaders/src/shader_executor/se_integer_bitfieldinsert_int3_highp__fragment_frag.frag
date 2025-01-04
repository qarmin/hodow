#version 450
layout(location = 0) flat in highp ivec3 vtx_out_base;
layout(location = 1) flat in highp ivec3 vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec3 o_result;

void main (void)
{
	highp ivec3 base = vtx_out_base;
	highp ivec3 insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
