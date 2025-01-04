#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp int vtx_out_lod;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	highp int lod = vtx_out_lod;
	highp ivec2 result;
	result = textureSize(u_image, lod);
	o_result = result;
}
