#version 450

layout(vertices = 1) out;

struct Inputs
{
	highp uvec3 x;
	highp uvec3 y;
};
struct Outputs
{
	highp uvec3 sum;
	lowp uvec3 carry;
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
	uvec3 x = uvec3(inputs[invocationId].x);
	uvec3 y = uvec3(inputs[invocationId].y);
	uvec3 sum;
	uvec3 carry;

	sum = uaddCarry(x, y, carry);

	outputs[invocationId].sum = sum;
	outputs[invocationId].carry = carry;
}
