#version 450
layout(location = 0) flat in lowp ivec3 vtx_out_msb;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	o_msb = vtx_out_msb;
}
