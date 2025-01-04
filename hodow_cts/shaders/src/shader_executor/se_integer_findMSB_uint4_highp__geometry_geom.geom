#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec4 vtx_out_value[];
layout(location = 0) flat out lowp ivec4 geom_out_msb;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec4 value = vtx_out_value[0];
	lowp ivec4 msb;

	msb = findMSB(value);
	geom_out_msb = msb;
    EmitVertex();
    EndPrimitive();
}
