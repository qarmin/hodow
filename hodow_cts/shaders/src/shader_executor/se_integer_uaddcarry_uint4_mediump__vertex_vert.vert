#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec4 a_x;
layout(location = 2) in mediump uvec4 a_y;
layout(location = 0) flat out mediump uvec4 vtx_out_sum;
layout(location = 1) flat out lowp uvec4 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec4 x = a_x;
	mediump uvec4 y = a_y;
	mediump uvec4 sum;
	lowp uvec4 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
