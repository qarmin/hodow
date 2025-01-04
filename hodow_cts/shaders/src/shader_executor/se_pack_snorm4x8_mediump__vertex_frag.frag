#version 450
layout(location = 0) flat in highp uint vtx_out_out0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
