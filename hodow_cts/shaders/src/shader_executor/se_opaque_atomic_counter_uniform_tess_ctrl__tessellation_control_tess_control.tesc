#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };
layout(set = 1, binding = 1, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};


layout(vertices = 1) out;

struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
