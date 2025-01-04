#version 450
layout(location = 0) flat in mediump ivec4 geom_out_result;
layout(location = 0) out mediump ivec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
