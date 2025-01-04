#version 450
layout(location = 0) flat in highp uint geom_out_extracted;
layout(location = 0) out highp uint o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
