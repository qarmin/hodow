#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out highp ivec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp ivec4 value = a_value;
	highp ivec4 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
