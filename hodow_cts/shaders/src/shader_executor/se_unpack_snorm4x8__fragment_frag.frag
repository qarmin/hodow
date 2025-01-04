#version 450
layout(location = 0) flat in highp uint vtx_out_in0;
layout(location = 0) out highp vec4 o_out0;

void main (void)
{
	highp uint in0 = vtx_out_in0;
	highp vec4 out0;
	out0 = unpackSnorm4x8(in0);
	o_out0 = out0;
}
