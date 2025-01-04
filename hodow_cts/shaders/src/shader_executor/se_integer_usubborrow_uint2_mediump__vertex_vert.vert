#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uvec2 a_x;
layout(location = 2) in mediump uvec2 a_y;
layout(location = 0) flat out mediump uvec2 vtx_out_diff;
layout(location = 1) flat out lowp uvec2 vtx_out_carry;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	mediump uvec2 x = a_x;
	mediump uvec2 y = a_y;
	mediump uvec2 diff;
	lowp uvec2 carry;
	diff = usubBorrow(x, y, carry);
	vtx_out_diff = diff;
	vtx_out_carry = carry;
}
