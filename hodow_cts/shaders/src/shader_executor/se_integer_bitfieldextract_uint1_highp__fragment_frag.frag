#version 450
layout(location = 0) flat in highp uint vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp uint o_extracted;

void main (void)
{
	highp uint value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uint extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
