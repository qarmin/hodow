#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp ivec2 vtx_out_result;
layout(location = 0) out highp ivec2 o_result;

void main (void)
{
	o_result = vtx_out_result;
}
