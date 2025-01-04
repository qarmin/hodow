#version 450
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) flat in mediump uint vtx_out_x[];
layout(location = 1) flat in mediump uint vtx_out_y[];
layout(location = 0) flat out mediump uint geom_out_sum;
layout(location = 1) flat out lowp uint geom_out_carry;

void main (void)
{
    gl_Position = gl_in[0].gl_Position;
	mediump uint x = vtx_out_x[0];
	mediump uint y = vtx_out_y[0];
	mediump uint sum;
	lowp uint carry;

	sum = uaddCarry(x, y, carry);
	geom_out_sum = sum;
	geom_out_carry = carry;
    EmitVertex();
    EndPrimitive();
}
