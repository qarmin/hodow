#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_base;
layout(location = 0) flat out mediump uvec4 vtx_out_base;
layout(location = 2) in mediump uvec4 a_insert;
layout(location = 1) flat out mediump uvec4 vtx_out_insert;
layout(location = 3) in mediump int a_offset;
layout(location = 2) flat out mediump int vtx_out_offset;
layout(location = 4) in mediump int a_bits;
layout(location = 3) flat out mediump int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
