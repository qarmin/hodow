#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp int value;
};
struct Outputs
{
	lowp int lsb;
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
	int value = int(inputs[invocationId].value);
	int lsb;

	lsb = findLSB(value);

	outputs[invocationId].lsb = lsb;
}
