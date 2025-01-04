#version 450
layout(location = 0) flat in mediump int vtx_out_result;
layout(location = 0) out mediump int o_result;

void main (void)
{
	o_result = vtx_out_result;
}
