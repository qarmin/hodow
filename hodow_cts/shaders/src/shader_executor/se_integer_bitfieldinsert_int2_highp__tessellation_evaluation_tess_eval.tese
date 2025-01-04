#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	highp ivec2 base;
	highp ivec2 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp ivec2 result;
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
	ivec2 base = ivec2(inputs[invocationId].base);
	ivec2 insert = ivec2(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	ivec2 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
