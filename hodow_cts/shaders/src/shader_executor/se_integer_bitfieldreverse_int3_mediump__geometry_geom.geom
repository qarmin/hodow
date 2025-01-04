#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump ivec3 vtx_out_value[];
layout(location = 0) flat out highp ivec3 geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump ivec3 value = vtx_out_value[0];
	highp ivec3 result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
