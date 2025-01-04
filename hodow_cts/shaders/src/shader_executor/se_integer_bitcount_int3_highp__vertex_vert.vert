#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec3 a_value;
layout(location = 0) flat out mediump ivec3 vtx_out_count;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec3 value = a_value;
	mediump ivec3 count;
	count = bitCount(value);
	vtx_out_count = count;
}
