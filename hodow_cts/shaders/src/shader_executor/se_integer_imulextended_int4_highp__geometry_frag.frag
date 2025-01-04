#version 450
layout(location = 0) flat in highp ivec4 geom_out_msb;
layout(location = 1) flat in highp ivec4 geom_out_lsb;
layout(location = 0) out highp ivec4 o_msb;
layout(location = 1) out highp ivec4 o_lsb;

void main (void)
{
	o_msb = geom_out_msb;
	o_lsb = geom_out_lsb;
}
