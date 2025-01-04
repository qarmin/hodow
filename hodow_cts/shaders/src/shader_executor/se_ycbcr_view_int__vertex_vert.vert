#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result0;
	highp ivec4 result1;
	result0 = texture(u_image, texCoord);
	result1 = ivec4(texture(u_planeView, texCoord));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
}
