#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec4 a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump ivec4 vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec4 value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump ivec4 extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
