#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_base[];
layout(location = 1) flat in highp ivec3 vtx_out_insert[];
layout(location = 2) flat in highp int vtx_out_offset[];
layout(location = 3) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 base = vtx_out_base[0];
	highp ivec3 insert = vtx_out_insert[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp ivec3 result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
