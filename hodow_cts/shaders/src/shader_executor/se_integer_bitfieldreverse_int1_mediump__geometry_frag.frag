#version 450
layout(location = 0) flat in highp int geom_out_result;
layout(location = 0) out highp int o_result;

void main (void)
{
	o_result = geom_out_result;
}
