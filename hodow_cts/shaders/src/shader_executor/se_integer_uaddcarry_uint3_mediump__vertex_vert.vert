#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec3 a_x;
layout(location = 2) in mediump uvec3 a_y;
layout(location = 0) flat out mediump uvec3 vtx_out_sum;
layout(location = 1) flat out lowp uvec3 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec3 x = a_x;
	mediump uvec3 y = a_y;
	mediump uvec3 sum;
	lowp uvec3 carry;
	sum = uaddCarry(x, y, carry);
	vtx_out_sum = sum;
	vtx_out_carry = carry;
}
