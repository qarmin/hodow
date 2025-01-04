#version 450
layout(location = 0) flat in highp uvec4 vtx_out_value;
layout(location = 1) flat in highp int vtx_out_offset;
layout(location = 2) flat in highp int vtx_out_bits;
layout(location = 0) out highp uvec4 o_extracted;

void main (void)
{
	highp uvec4 value = vtx_out_value;
	highp int offset = vtx_out_offset;
	highp int bits = vtx_out_bits;
	highp uvec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	o_extracted = extracted;
}
