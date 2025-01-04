#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) flat in highp vec4 geom_out_result0;
layout(location = 1) flat in highp uvec4 geom_out_result1;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;

void main (void)
{
	o_result0 = geom_out_result0;
	o_result1 = geom_out_result1;
}
