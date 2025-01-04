#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp uint a_base;
layout(location = 0) flat out highp uint vtx_out_base;
layout(location = 2) in highp uint a_insert;
layout(location = 1) flat out highp uint vtx_out_insert;
layout(location = 3) in highp int a_offset;
layout(location = 2) flat out highp int vtx_out_offset;
layout(location = 4) in highp int a_bits;
layout(location = 3) flat out highp int vtx_out_bits;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_base = a_base;
	vtx_out_insert = a_insert;
	vtx_out_offset = a_offset;
	vtx_out_bits = a_bits;
}
