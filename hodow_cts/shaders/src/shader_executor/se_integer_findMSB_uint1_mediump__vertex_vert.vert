#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_value;
layout(location = 0) flat out lowp int vtx_out_msb;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint value = a_value;
	lowp int msb;
	msb = findMSB(value);
	vtx_out_msb = msb;
}
