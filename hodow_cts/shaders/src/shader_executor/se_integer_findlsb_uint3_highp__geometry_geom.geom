#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_value[];
layout(location = 0) flat out lowp ivec3 geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 value = vtx_out_value[0];
	lowp ivec3 lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
