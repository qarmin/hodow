#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out mediump ivec4 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	mediump ivec4 count;
	count = bitCount(value);
	vtx_out_count = count;
}
