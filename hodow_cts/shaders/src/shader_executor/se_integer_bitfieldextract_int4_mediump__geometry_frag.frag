#version 450
layout(location = 0) flat in mediump ivec4 geom_out_extracted;
layout(location = 0) out mediump ivec4 o_extracted;

void main (void)
{
	o_extracted = geom_out_extracted;
}
