#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec4 vtx_out_x[];
layout(location = 1) flat in mediump uvec4 vtx_out_y[];
layout(location = 0) flat out mediump uvec4 geom_out_diff;
layout(location = 1) flat out lowp uvec4 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec4 x = vtx_out_x[0];
	mediump uvec4 y = vtx_out_y[0];
	mediump uvec4 diff;
	lowp uvec4 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
