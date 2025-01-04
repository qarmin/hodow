#version 450
layout(location = 0) flat in lowp ivec2 vtx_out_lsb;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
