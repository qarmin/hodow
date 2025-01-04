#version 450
layout(location = 0) flat in highp uint geom_out_out0;
layout(location = 0) out highp uint o_out0;

void main (void)
{
	o_out0 = geom_out_out0;
}
