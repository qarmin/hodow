#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uvec3 a_value;
layout(location = 0) flat out lowp ivec3 vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec3 value = a_value;
	lowp ivec3 msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
