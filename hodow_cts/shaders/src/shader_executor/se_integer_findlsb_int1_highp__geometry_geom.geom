#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp int vtx_out_value[];
layout(location = 0) flat out lowp int geom_out_lsb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp int value = vtx_out_value[0];
	lowp int lsb;

	lsb = findLSB(value);
	geom_out_lsb = lsb;
    EmitVertex();
    EndPrimitive();
}
