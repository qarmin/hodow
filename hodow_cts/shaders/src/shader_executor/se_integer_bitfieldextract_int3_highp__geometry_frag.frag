#version 450
layout(location = 0) flat in highp ivec3 geom_out_extracted;
layout(location = 0) out highp ivec3 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
