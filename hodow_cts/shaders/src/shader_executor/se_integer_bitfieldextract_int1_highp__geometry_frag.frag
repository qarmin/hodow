#version 450
layout(location = 0) flat in highp int geom_out_extracted;
layout(location = 0) out highp int o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
