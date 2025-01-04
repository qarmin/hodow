#version 450
layout(location = 0) flat in mediump ivec2 vtx_out_count;
layout(location = 0) out mediump ivec2 o_count;

void main (void)
{
	o_count = vtx_out_count;
}
