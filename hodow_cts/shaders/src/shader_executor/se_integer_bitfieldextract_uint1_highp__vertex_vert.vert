#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_value;
layout(location = 2) in highp int a_offset;
layout(location = 3) in highp int a_bits;
layout(location = 0) flat out highp uint vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uint value = a_value;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp uint extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
