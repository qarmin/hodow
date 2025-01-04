#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec4 base;
	highp ivec4 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec4 result;
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
	ivec4 base = ivec4(inputs[invocationId].base);
	ivec4 insert = ivec4(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec4 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
