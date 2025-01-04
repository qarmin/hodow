#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec4 value = vtx_out_value[0];
	lowp ivec4 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
