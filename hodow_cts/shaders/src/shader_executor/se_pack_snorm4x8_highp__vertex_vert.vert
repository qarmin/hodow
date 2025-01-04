#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec4 a_in0;
layout(location = 0) flat out highp uint vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec4 in0 = a_in0;
	highp uint out0;
	out0 = packSnorm4x8(in0);
	vtx_out_out0 = out0;
}
