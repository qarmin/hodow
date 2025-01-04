#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp isampler2D texSampler[8];

layout(location = 0) flat in highp vec2 vtx_out_coords;
layout(location = 0) out highp ivec4 o_result0;
layout(location = 1) out highp ivec4 o_result1;
layout(location = 2) out highp ivec4 o_result2;
layout(location = 3) out highp ivec4 o_result3;

void main (void)
{
	highp vec2 coords = vtx_out_coords;
	highp ivec4 result0;
	highp ivec4 result1;
	highp ivec4 result2;
	highp ivec4 result3;
	result0 = texture(texSampler[indexBase + 0], coords);
	result1 = texture(texSampler[indexBase + 1], coords);
	result2 = texture(texSampler[indexBase + 1], coords);
	result3 = texture(texSampler[indexBase + 1], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
