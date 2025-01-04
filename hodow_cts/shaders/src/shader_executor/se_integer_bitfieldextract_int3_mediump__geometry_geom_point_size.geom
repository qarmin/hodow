#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 1) flat in mediump int vtx_out_offset[];
layout(location = 2) flat in mediump int vtx_out_bits[];
layout(location = 0) flat out mediump ivec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec3 value = vtx_out_value[0];
	mediump int offset = vtx_out_offset[0];
	mediump int bits = vtx_out_bits[0];
	mediump ivec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
