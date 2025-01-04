#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec3 vtx_out_value[];
layout(location = 0) flat out mediump ivec3 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp ivec3 value = vtx_out_value[0];
	mediump ivec3 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
