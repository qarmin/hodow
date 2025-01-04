#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_value[];
layout(location = 0) flat out highp uvec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
    gl_PointSize = gl_in[0].gl_PointSize;

	mediump uvec3 value = vtx_out_value[0];
	highp uvec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
