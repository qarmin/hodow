#version 450
layout(location = 0) flat in lowp int geom_out_msb;
layout(location = 0) out lowp int o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
