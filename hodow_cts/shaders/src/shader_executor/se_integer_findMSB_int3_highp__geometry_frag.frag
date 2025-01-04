#version 450
layout(location = 0) flat in lowp ivec3 geom_out_msb;
layout(location = 0) out lowp ivec3 o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
