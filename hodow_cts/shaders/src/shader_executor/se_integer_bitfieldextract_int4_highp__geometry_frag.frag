#version 450
layout(location = 0) flat in highp ivec4 geom_out_extracted;
layout(location = 0) out highp ivec4 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
