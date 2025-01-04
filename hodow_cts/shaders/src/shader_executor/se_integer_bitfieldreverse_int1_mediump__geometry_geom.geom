#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump int vtx_out_value[];
layout(location = 0) flat out highp int geom_out_result;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump int value = vtx_out_value[0];
	highp int result;

	result = bitfieldReverse(value);
	geom_out_result = result;
    EmitVertex();
    EndPrimitive();
}
