#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out lowp int vtx_out_lsb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	lowp int lsb;
	lsb = findLSB(value);
	vtx_out_lsb = lsb;
}
