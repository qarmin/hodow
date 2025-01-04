#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_lod;
layout(location = 0) flat out highp ivec2 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int lod = a_lod;
	highp ivec2 result;
	result = textureSize(u_image, lod);
	vtx_out_result = result;
}
