#version 450
layout(set=1, binding=7) uniform highp sampler2D u_sampler[4];
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_uv;
layout(location = 0) flat out highp vec2 vtx_out_uv;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_uv = a_uv;
}
