#version 450
layout(location = 0) flat in highp ivec4 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp ivec4 o_extracted;

void main (void)
{
	highp ivec4 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp ivec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
