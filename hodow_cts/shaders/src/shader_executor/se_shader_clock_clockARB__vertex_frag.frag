#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable

layout(location = 0) flat in highp uvec2 vtx_out_out0;
layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	o_out0 = vtx_out_out0;
}
