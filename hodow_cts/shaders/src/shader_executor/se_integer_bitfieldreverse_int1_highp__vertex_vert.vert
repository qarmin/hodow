#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_value;
layout(location = 0) flat out highp int vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int value = a_value;
	highp int result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
