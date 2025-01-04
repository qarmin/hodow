#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result;
	result = texture(u_image, texCoord);
	o_result = result;
}
