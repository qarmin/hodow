#version 450
layout(location = 0) flat in highp vec4 vtx_out_out0;
layout(location = 0) out highp vec4 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
