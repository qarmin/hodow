#version 450
layout(location = 0) flat in mediump ivec3 vtx_out_result;
layout(location = 0) out mediump ivec3 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
