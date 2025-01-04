#version 450
layout(set = 1, binding = 0) uniform highp usampler3D texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 0) out highp uvec4 o_result0;
layout(location = 1) out highp uvec4 o_result1;
layout(location = 2) out highp uvec4 o_result2;
layout(location = 3) out highp uvec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp uvec4 result0;
	highp uvec4 result1;
	highp uvec4 result2;
	highp uvec4 result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[0], coords);
	result2 = texture(texSampler[4], coords);
	result3 = texture(texSampler[0], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
