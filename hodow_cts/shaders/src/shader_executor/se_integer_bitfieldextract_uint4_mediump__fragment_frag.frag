#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_value;
layout(location = 1) flat in mediump int vtx_out_offset;
layout(location = 2) flat in mediump int vtx_out_bits;
layout(location = 0) out mediump uvec4 o_extracted;

void main (void)
{
	mediump uvec4 value = vtx_out_value;
	mediump int offset = vtx_out_offset;
	mediump int bits = vtx_out_bits;
	mediump uvec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
