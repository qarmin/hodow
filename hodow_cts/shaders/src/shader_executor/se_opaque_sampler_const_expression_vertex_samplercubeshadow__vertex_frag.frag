#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) uniform highp samplerCubeShadow texSampler[8];

layout(location = 0) flat in highp float vtx_out_result0;
layout(location = 1) flat in highp float vtx_out_result1;
layout(location = 2) flat in highp float vtx_out_result2;
layout(location = 3) flat in highp float vtx_out_result3;
layout(location = 0) out highp float o_result0;
layout(location = 1) out highp float o_result1;
layout(location = 2) out highp float o_result2;
layout(location = 3) out highp float o_result3;

void main (void)
{
	o_result0 = vtx_out_result0;
	o_result1 = vtx_out_result1;
	o_result2 = vtx_out_result2;
	o_result3 = vtx_out_result3;
}
