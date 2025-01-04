#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_value;
layout(location = 0) flat out highp uvec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 value = a_value;
	highp uvec2 result;
	result = bitfieldReverse(value);
	vtx_out_result = result;
}
