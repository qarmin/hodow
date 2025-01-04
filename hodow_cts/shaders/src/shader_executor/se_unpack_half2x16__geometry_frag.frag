#version 450
layout(location = 0) flat in mediump vec2 geom_out_out0;
layout(location = 0) out mediump vec2 o_out0;

void main (void)
{
	o_out0 = geom_out_out0;
}
