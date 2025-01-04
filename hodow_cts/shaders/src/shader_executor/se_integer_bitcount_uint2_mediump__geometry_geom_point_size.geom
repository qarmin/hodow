#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_value[];
layout(location = 0) flat out mediump ivec2 geom_out_count;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec2 value = vtx_out_value[0];
	mediump ivec2 count;

	count = bitCount(value);
	geom_out_count = count;
    EmitVertex();
    EndPrimitive();
}
