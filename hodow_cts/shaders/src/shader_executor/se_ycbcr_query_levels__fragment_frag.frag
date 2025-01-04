#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp int vtx_out_lod;
layout(location = 0) out highp int o_result;

void main (void)
{
	highp int lod = vtx_out_lod;
	highp int result;
	result = textureQueryLevels(u_image);
	o_result = result;
}
