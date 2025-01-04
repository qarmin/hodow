#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 1) flat in highp int vtx_out_offset[];
layout(location = 2) flat in highp int vtx_out_bits[];
layout(location = 0) flat out highp uvec3 geom_out_extracted;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	highp int offset = vtx_out_offset[0];
	highp int bits = vtx_out_bits[0];
	highp uvec3 extracted;

	extracted = bitfieldExtract(value, offset, bits);
	geom_out_extracted = extracted;
    EmitVertex();
    EndPrimitive();
}
