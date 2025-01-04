#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint value;
	highp int offset;
	highp int bits;
};
struct Outputs
{
	highp uint extracted;
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
	uint value = uint(inputs[invocationId].value);
	int offset = int(inputs[invocationId].offset);
	int bits = int(inputs[invocationId].bits);
	uint extracted;

	extracted = bitfieldExtract(value, offset, bits);

	outputs[invocationId].extracted = extracted;
}
