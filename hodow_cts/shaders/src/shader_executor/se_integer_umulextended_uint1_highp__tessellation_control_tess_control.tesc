#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uint x;
	highp uint y;
};
struct Outputs
{
	highp uint msb;
	highp uint lsb;
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
	uint x = uint(inputs[invocationId].x);
	uint y = uint(inputs[invocationId].y);
	uint msb;
	uint lsb;

	umulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
