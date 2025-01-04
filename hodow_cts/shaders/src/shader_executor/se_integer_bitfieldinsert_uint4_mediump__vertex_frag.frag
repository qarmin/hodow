#version 450
layout(location = 0) flat in mediump uvec4 vtx_out_result;
layout(location = 0) out mediump uvec4 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
