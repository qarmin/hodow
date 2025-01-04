#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp ivec4 vtx_out_value[];
layout(location = 0) flat out mediump ivec4 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	highp ivec4 value = vtx_out_value[0];
	mediump ivec4 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
