#version 450
layout(binding = 0, set = 1) uniform highp sampler2DArray u_image;

layout(location = 0) flat in highp vec4 geom_out_result;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	o_result = geom_out_result;
}
