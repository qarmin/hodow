#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp ivec3 x;
	highp ivec3 y;
};
struct Outputs
{
	highp ivec3 msb;
	highp ivec3 lsb;
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
	ivec3 x = ivec3(inputs[invocationId].x);
	ivec3 y = ivec3(inputs[invocationId].y);
	ivec3 msb;
	ivec3 lsb;

	imulExtended(x, y, msb, lsb);

	outputs[invocationId].msb = msb;
	outputs[invocationId].lsb = lsb;
}
