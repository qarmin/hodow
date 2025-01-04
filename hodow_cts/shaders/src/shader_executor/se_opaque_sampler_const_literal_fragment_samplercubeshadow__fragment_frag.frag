#version 450
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp vec4 vtx_out_coords;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	highp vec4 coords = vtx_out_coords;
	highp float result0;
	highp float result1;
	highp float result2;
	highp float result3;
	result0 = texture(texSampler[0], coords);
	result1 = texture(texSampler[4], coords);
	result2 = texture(texSampler[5], coords);
	result3 = texture(texSampler[4], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
