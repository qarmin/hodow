#version 450
layout(location = 0) flat in highp uint vtx_out_result;
layout(location = 0) out highp uint o_result;

void main (void)
{
	o_result = vtx_out_result;
}
