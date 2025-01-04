#version 450
#extension GL_EXT_gpu_shader5 : require
layout(set = 1, binding = 0) uniform Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

struct Inputs
{
	highp int index0;
	highp int index1;
	highp int index2;
	highp int index3;
};
struct Outputs
{
	highp uint result0;
	highp uint result1;
	highp uint result2;
	highp uint result3;
};

layout(set = 0, binding = 0, std430) buffer InBuffer
{
    Inputs inputs[];
};
layout(set = 0, binding = 1, std430) buffer OutBuffer
{
    Outputs outputs[];
};

void main (void)
{
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	int index0 = int(inputs[invocationId].index0);
	int index1 = int(inputs[invocationId].index1);
	int index2 = int(inputs[invocationId].index2);
	int index3 = int(inputs[invocationId].index3);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[index0].value;
	result1 = block[index1].value;
	result2 = block[index2].value;
	result3 = block[index3].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
