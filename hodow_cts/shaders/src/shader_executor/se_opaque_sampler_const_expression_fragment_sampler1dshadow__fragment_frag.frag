#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp sampler1DShadow texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[indexBase + 4], coords);
	result1 = texture(texSampler[indexBase + 2], coords);
	result2 = texture(texSampler[indexBase + -1], coords);
	result3 = texture(texSampler[indexBase + -1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
