#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_value[];
layout(location = 0) flat out highp uvec4 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 value = vtx_out_value[0];
	highp uvec4 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
