#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_base;
layout(location = 1) flat in mediump ivec3 vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump ivec3 o_result;

void main (void)
{
	mediump ivec3 base = vtx_out_base;
	mediump ivec3 insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump ivec3 result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
