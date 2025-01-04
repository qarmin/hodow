#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_x;
layout(location = 2) in mediump uint a_y;
layout(location = 0) flat out mediump uint vtx_out_sum;
layout(location = 1) flat out lowp uint vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uint x = a_x;
	mediump uint y = a_y;
	mediump uint sum;
	lowp uint carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
