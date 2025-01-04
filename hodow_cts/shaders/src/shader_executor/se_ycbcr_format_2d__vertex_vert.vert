#version 450
layout(binding = 0, set = 1) uniform highp sampler2D u_image;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec4 vtx_out_result;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 texCoord = a_texCoord;
	highp vec4 result;
	result = texture(u_image, texCoord);
	vtx_out_result = result;
}
