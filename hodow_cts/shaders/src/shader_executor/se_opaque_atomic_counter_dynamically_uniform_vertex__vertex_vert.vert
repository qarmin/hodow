#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0, std430) buffer AtomicBuffer { highp uint counter[4]; };

layout(location = 0) in highp vec4 a_position;
layout(location = 1) in highp int a_index0;
layout(location = 2) in highp int a_index1;
layout(location = 3) in highp int a_index2;
layout(location = 4) in highp int a_index3;
layout(location = 0) flat out highp uint vtx_out_result0;
layout(location = 1) flat out highp uint vtx_out_result1;
layout(location = 2) flat out highp uint vtx_out_result2;
layout(location = 3) flat out highp uint vtx_out_result3;

void main (void)
{
    gl_Position = a_position;
    gl_PointSize = 1.0;
	highp int index0 = a_index0;
	highp int index1 = a_index1;
	highp int index2 = a_index2;
	highp int index3 = a_index3;
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
	result0 = atomicAdd(counter[index0], uint(1));
	result1 = atomicAdd(counter[index1], uint(1));
	result2 = atomicAdd(counter[index2], uint(1));
	result3 = atomicAdd(counter[index3], uint(1));
	vtx_out_result0 = result0;
	vtx_out_result1 = result1;
	vtx_out_result2 = result2;
	vtx_out_result3 = result3;
}
