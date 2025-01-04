#version 450
layout(location = 0) flat in lowp ivec4 geom_out_lsb;
layout(location = 0) out lowp ivec4 o_lsb;

void main (void)
{
	o_lsb = geom_out_lsb;
}
