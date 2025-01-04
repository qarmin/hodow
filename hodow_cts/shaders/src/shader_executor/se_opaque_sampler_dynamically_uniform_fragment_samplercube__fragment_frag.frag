#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform highp samplerCube texSampler[8];

layout(location = 0) flat in highp vec3 vtx_out_coords;
layout(location = 1) flat in highp int vtx_out_index0;
layout(location = 2) flat in highp int vtx_out_index1;
layout(location = 3) flat in highp int vtx_out_index2;
layout(location = 4) flat in highp int vtx_out_index3;
layout(location = 0) out highp vec4 o_result0;
layout(location = 1) out highp vec4 o_result1;
layout(location = 2) out highp vec4 o_result2;
layout(location = 3) out highp vec4 o_result3;

void main (void)
{
	highp vec3 coords = vtx_out_coords;
	highp int index0 = vtx_out_index0;
	highp int index1 = vtx_out_index1;
	highp int index2 = vtx_out_index2;
	highp int index3 = vtx_out_index3;
	highp vec4 result0;
	highp vec4 result1;
	highp vec4 result2;
	highp vec4 result3;
	result0 = texture(texSampler[index0], coords);
	result1 = texture(texSampler[index1], coords);
	result2 = texture(texSampler[index2], coords);
	result3 = texture(texSampler[index3], coords);
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
