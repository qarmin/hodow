#version 450
layout(location = 0) flat in lowp int vtx_out_lsb;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	o_lsb = vtx_out_lsb;
}
