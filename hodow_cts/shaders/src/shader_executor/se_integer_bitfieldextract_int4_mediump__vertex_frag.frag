#version 450
layout(location = 0) flat in mediump ivec4 vtx_out_extracted;
layout(location = 0) out mediump ivec4 o_extracted;

void main (void)
{
	o_extracted = vtx_out_extracted;
}
