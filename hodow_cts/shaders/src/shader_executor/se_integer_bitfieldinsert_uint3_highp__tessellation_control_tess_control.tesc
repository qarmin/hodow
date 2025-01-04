#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 base;
	highp uvec3 insert;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uvec3 result;
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
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = 1.0;
	gl_TessLevelOuter[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = 1.0;
	gl_TessLevelOuter[3] = 1.0;

	highp uint invocationId = uint(gl_PrimitiveID);
	uvec3 base = uvec3(inputs[invocationId].base);
	uvec3 insert = uvec3(inputs[invocationId].insert);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uvec3 result;

	result = bitfieldInsert(base, insert, offset, bits);

	outputs[invocationId].result = result;
}
