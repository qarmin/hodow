#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec4 x;
	highp ivec4 y;
};
struct Outputs
{
	highp ivec4 msb;
	highp ivec4 lsb;
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
	ivec4 x = ivec4(inputs[invocationId].x);
	ivec4 y = ivec4(inputs[invocationId].y);
	ivec4 msb;
	ivec4 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
