#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec2 vtx_out_value[];
layout(location = 0) flat out highp ivec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump ivec2 value = vtx_out_value[0];
	highp ivec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
