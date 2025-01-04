#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uvec2 vtx_out_x[];
layout(location = 1) flat in mediump uvec2 vtx_out_y[];
layout(location = 0) flat out mediump uvec2 geom_out_sum;
layout(location = 1) flat out lowp uvec2 geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uvec2 x = vtx_out_x[0];
	mediump uvec2 y = vtx_out_y[0];
	mediump uvec2 sum;
	lowp uvec2 carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
