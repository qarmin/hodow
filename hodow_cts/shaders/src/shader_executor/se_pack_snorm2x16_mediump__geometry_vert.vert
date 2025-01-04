#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in mediump vec2 a_in0;
layout(location = 0) flat out mediump vec2 vtx_out_in0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_in0 = a_in0;
}
