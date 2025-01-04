#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp uvec4 vtx_out_result0;
layout(location = 1) flat out highp uvec4 vtx_out_result1;
layout(location = 2) flat out highp uvec4 vtx_out_result2;
layout(location = 3) flat out highp uvec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[indexBase + -1], coords);
	result1 = texture(texSampler[indexBase + -1], coords);
	result2 = texture(texSampler[indexBase + 3], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
