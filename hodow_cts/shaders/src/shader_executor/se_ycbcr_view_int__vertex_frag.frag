#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) flat in highp vec4 vtx_out_result0;
layout(location = 1) flat in highp ivec4 vtx_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
}
