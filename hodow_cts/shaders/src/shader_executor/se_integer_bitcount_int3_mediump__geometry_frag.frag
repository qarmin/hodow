#version 450
layout(location = 0) flat in mediump ivec3 geom_out_count;
layout(location = 0) out mediump ivec3 o_count;

void main (void)
{
	o_count = geom_out_count;
}
