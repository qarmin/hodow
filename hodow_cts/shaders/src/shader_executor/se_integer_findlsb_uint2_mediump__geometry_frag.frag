#version 450
layout(location = 0) flat in lowp ivec2 geom_out_lsb;
layout(location = 0) out lowp ivec2 o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
