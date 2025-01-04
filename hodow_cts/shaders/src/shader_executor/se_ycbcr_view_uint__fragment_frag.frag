#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp usampler2D u_planeView;

layout(location = 0) flat in highp vec2 vtx_out_texCoord;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;

void main (void)
{
	highp vec2 texCoord = vtx_out_texCoord;
	highp vec4 result0;
	highp uvec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = uvec4(texture(u_planeView, texCoord));
	o_result0 = result0;
	o_result1 = result1;
}
