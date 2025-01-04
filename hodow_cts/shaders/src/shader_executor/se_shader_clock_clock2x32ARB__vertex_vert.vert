#version 450
#extension GL_ARB_shader_clock : enable

layout(location = 0) in highp vec4 a_position;
layout(location = 0) flat out highp uvec2 vtx_out_out0;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp uvec2 out0;
	uvec2 time1 = clock2x32ARB();
	uvec2 time2 = clock2x32ARB();
	out0 = uvec2(0, 0);
	if (time1.y > time2.y || (time1.y == time2.y && time1.x > time2.x)){
	    out0.x = 1;
	}
	vtx_out_out0 = out0;
}
