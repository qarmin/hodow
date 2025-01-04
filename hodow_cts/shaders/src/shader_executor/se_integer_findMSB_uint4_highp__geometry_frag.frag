#version 450
layout(location = 0) flat in lowp ivec4 geom_out_msb;
layout(location = 0) out lowp ivec4 o_msb;

void main (void)
{
	o_msb = geom_out_msb;
}
