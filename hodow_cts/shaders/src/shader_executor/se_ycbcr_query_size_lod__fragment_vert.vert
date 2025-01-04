#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_lod;
layout(location = 0) flat out highp int vtx_out_lod;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_lod = a_lod;
}
