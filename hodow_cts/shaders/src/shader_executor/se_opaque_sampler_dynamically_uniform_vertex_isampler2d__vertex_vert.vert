#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec2 a_coords;
layout(location = 2) in highp int a_index0;
layout(location = 3) in highp int a_index1;
layout(location = 4) in highp int a_index2;
layout(location = 5) in highp int a_index3;
layout(location = 0) flat out highp ivec4 vtx_out_result0;
layout(location = 1) flat out highp ivec4 vtx_out_result1;
layout(location = 2) flat out highp ivec4 vtx_out_result2;
layout(location = 3) flat out highp ivec4 vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec2 coords = a_coords;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
