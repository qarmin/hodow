#version 450

layout(isolines, equal_spacing) in;

struct Inputs
{
	mediump uint base;
	mediump uint insert;
	mediump int offset;
	mediump int bits;
};
struct Outputs
{
	mediump uint result;
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
	uint base = uint(inputs[invocationId].base);
	uint insert = uint(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
