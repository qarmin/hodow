#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec2 vtx_out_value[];
layout(location = 0) flat out highp uvec2 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec2 value = vtx_out_value[0];
	highp uvec2 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
