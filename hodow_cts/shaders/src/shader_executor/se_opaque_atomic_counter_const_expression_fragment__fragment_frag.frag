#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) out highp uint o_result0;
layout(location = 1) out highp uint o_result1;
layout(location = 2) out highp uint o_result2;
layout(location = 3) out highp uint o_result3;

void main (void)
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[indexBase + 1], uint(1));
	result1 = atomicAdd(counter[indexBase + 1], uint(1));
	result2 = atomicAdd(counter[indexBase + -1], uint(1));
	result3 = atomicAdd(counter[indexBase + -1], uint(1));
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
