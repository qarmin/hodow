#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp sampler2DShadow texSampler[8];
layout(set = 1, binding = 8, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp vec3 a_coords;
layout(location = 0) flat out highp float vtx_out_result0;
layout(location = 1) flat out highp float vtx_out_result1;
layout(location = 2) flat out highp float vtx_out_result2;
layout(location = 3) flat out highp float vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp vec3 coords = a_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
