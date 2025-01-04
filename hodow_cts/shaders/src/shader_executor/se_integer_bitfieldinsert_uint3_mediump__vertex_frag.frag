#version 450
layout(location = 0) flat in mediump uvec3 vtx_out_result;
layout(location = 0) out mediump uvec3 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
