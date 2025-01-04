#version 450
layout(location = 0) flat in mediump vec4 vtx_out_in0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	mediump vec4 in0 = vtx_out_in0;
	highp uint out0;
	out0 = packSnorm4x8(in0);
	o_out0 = out0;
}
