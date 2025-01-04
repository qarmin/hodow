#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_base;
layout(location = 2) in mediump uint a_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 0) flat out mediump uint vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint base = a_base;
	mediump uint insert = a_insert;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump uint result;
	result = bitfieldInsert(base, insert, offset, bits);
	vtx_out_result = result;
}
