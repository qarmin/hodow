#version 450
layout(location = 0) flat in mediump ivec4 geom_out_count;
layout(location = 0) out mediump ivec4 o_count;

void main (void)
{
	o_count = geom_out_count;
}
