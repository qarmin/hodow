#version 450
layout(location = 0) flat in lowp int vtx_out_msb;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	o_msb = vtx_out_msb;
}
