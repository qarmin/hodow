#version 450
layout(binding = 1, set = 1) uniform highp sampler2D u_image;
layout(binding = 0, set = 1) uniform highp isampler2D u_planeView;

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_texCoord;
layout(location = 0) flat out highp vec2 vtx_out_texCoord;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	vtx_out_texCoord = a_texCoord;
}
