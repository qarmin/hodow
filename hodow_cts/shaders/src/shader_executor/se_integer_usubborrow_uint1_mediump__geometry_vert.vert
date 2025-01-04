#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump uint a_x;
layout(location = 0) flat out mediump uint vtx_out_x;
layout(location = 2) in mediump uint a_y;
layout(location = 1) flat out mediump uint vtx_out_y;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_x = a_x;
	vtx_out_y = a_y;
}
