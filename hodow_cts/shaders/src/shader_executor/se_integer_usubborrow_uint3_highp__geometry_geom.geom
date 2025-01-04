#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in highp uvec3 vtx_out_x[];
layout(location = 1) flat in highp uvec3 vtx_out_y[];
layout(location = 0) flat out highp uvec3 geom_out_diff;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	highp uvec3 x = vtx_out_x[0];
	highp uvec3 y = vtx_out_y[0];
	highp uvec3 diff;
	lowp uvec3 carry;

	diff = usubBorrow(x, y, carry);
	geom_out_diff = diff;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
