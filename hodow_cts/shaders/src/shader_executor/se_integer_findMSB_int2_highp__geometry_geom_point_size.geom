#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec2 vtx_out_value[];
layout(location = 0) flat out lowp ivec2 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec2 value = vtx_out_value[0];
	lowp ivec2 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
