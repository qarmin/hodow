#version 450
layout(location = 0) flat in highp uvec4 vtx_out_result;
layout(location = 0) out highp uvec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
