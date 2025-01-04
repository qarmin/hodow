#version 450
layout(location = 0) flat in lowp ivec3 vtx_out_lsb;
layout(location = 0) out lowp ivec3 o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
