#version 450
#extension GL_EXT_gpu_shader5 : require
const highp int indexBase = 1;
layout(set = 1, binding = 0) readonly buffer Block
{
    highp uint value;
} block[4];


layout(isolines, equal_spacing) in;

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
	gl_Position = vec4(gl_TessCoord.x, 0.0, 0.0, 1.0);
	highp uint invocationId = uint(gl_PrimitiveID)*2u + (gl_TessCoord.x > 0.5 ? 1u : 0u);
	uint result0;
	uint result1;
	uint result2;
	uint result3;

	result0 = block[indexBase + 1].value;
	result1 = block[indexBase + -1].value;
	result2 = block[indexBase + 0].value;
	result3 = block[indexBase + 2].value;

	outputs[invocationId].result0 = result0;
	outputs[invocationId].result1 = result1;
	outputs[invocationId].result2 = result2;
	outputs[invocationId].result3 = result3;
}
