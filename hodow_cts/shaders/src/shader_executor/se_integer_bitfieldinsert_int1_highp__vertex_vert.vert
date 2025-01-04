#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_base;
layout(location = 2) in highp int a_insert;
layout(location = 3) in highp int a_offset;
layout(location = 4) in highp int a_bits;
layout(location = 0) flat out highp int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int base = a_base;
	highp int insert = a_insert;
	highp int offset = a_offset;
	highp int bits = a_bits;
	highp int result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
