#version 450
layout(location = 0) flat in mediump uint vtx_out_base;
layout(location = 1) flat in mediump uint vtx_out_insert;
layout(location = 2) flat in mediump int vtx_out_offset;
layout(location = 3) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uint o_result;

void main (void)
{
	mediump uint base = vtx_out_base;
	mediump uint insert = vtx_out_insert;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	o_result = result;
}
