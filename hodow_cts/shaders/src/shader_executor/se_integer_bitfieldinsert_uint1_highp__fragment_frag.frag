#version 450
layout(location = 0) flat in highp uint vtx_out_base;
layout(location = 1) flat in highp uint vtx_out_insert;
layout(location = 2) flat in highp int vtx_out_offset;
layout(location = 3) flat in highp int vtx_out_bits;
layout(location = 0) out highp uint o_result;

void main (void)
{
	highp uint base = vtx_out_base;
	highp uint insert = vtx_out_insert;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
