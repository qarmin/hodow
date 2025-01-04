#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp ivec4 a_value;
layout(location = 0) flat out highp ivec4 vtx_out_value;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_value = a_value;
}
