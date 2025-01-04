#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_base[];
layout(location = 1) flat in mediump int vtx_out_insert[];
layout(location = 2) flat in mediump int vtx_out_offset[];
layout(location = 3) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int base = vtx_out_base[0];
	mediump int insert = vtx_out_insert[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump int result;

	result = bitfieldInsert(base, insert, offset, bits);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
