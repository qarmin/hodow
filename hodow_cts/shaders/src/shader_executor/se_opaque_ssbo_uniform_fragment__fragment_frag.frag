#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];
layout(set = 1, binding = 4, std140) uniform Indices
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};

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
	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;
	o_result0 = result0;
	o_result1 = result1;
	o_result2 = result2;
	o_result3 = result3;
}
