#version 450
layout(location = 0) flat in lowp int geom_out_lsb;
layout(location = 0) out lowp int o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
