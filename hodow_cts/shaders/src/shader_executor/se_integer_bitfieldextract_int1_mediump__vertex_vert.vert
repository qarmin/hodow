#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump int a_value;
layout(location = 2) in mediump int a_offset;
layout(location = 3) in mediump int a_bits;
layout(location = 0) flat out mediump int vtx_out_extracted;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump int value = a_value;
	mediump int offset = a_offset;
	mediump int bits = a_bits;
	mediump int extracted;
	extracted = bitfieldExtract(value, offset, bits);
	vtx_out_extracted = extracted;
}
