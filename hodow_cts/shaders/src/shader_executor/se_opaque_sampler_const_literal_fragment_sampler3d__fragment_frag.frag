#version 450
layout(set = 1, binding = 0) uniform highp sampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[7], coords);
	result1 = texture(texSampler[6], coords);
	result2 = texture(texSampler[3], coords);
	result3 = texture(texSampler[6], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
