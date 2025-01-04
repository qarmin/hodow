#version 450
layout(set = 1, binding = 0) uniform highp isampler1D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp float a_coords;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp float coords = a_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[2], coords);
	result3 = texture(texSampler[2], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
