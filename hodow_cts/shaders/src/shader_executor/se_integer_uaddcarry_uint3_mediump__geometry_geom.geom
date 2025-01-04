#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec3 vtx_out_x[];
layout(location = 1) flat in mediump uvec3 vtx_out_y[];
layout(location = 0) flat out mediump uvec3 geom_out_sum;
layout(location = 1) flat out lowp uvec3 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec3 x = vtx_out_x[0];
	mediump uvec3 y = vtx_out_y[0];
	mediump uvec3 sum;
	lowp uvec3 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
