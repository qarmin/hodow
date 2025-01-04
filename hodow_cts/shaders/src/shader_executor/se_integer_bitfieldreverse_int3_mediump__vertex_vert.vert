#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump ivec3 a_value;
layout(location = 0) flat out highp ivec3 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump ivec3 value = a_value;
	highp ivec3 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
