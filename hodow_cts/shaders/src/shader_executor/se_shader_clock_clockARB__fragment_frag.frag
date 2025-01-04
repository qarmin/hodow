#version 450
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_ARB_shader_clock : enable

layout(location = 0) out highp uvec2 o_out0;

void main (void)
{
	highp uvec2 out0;
	uint64_t time1 = clockARB();
	uint64_t time2 = clockARB();
	out0 = uvec2(0, 0);
	if (time1 > time2) {
	    out0.x = 1;
	}
	o_out0 = out0;
}
